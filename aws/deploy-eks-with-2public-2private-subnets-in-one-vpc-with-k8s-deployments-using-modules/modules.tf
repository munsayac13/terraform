module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = local.vpc_name
  cidr = local.mylocalone_cidr

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = [local.mylocalone_private_a, local.mylocalone_private_b]
  public_subnets  = [local.mylocalone_public_a, local.mylocalone_public_b]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = var.myenvironment
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  # Make eks cluster allow access from eks control plane to the webhook port of the AWS Load Balancer Controller

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name = "mylocalone-k8s-cluster"
  cluster_version = "1.31"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  vpc_id = module.vpc.vpc_id
  subnets_ids = module.vpc.private_subnets
  
  enable_irsa = true    # IAM Role Service Accounts

  eks_managd_node_group_defaults = {
    disk_size = 60
  }

  eks_managed_node_groups = {
    nodes = {
      min_size = 1
      max_size = 1
      desired_size = 1

      instance_types = ["t3.large"]
    }
  }

  tags = {
    Environment = var.myenvironment
  } 
}

module "allow_eks_access_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.55.0"

  name = "allow-eks-access"
  creation_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:DescribeFargateProfile",
          "eks:ListFargateProfiles",
          "eks:DescribeNodeGroup",
          "eks:ListNodeGroups"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "eks_admins_iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.55.0"
  role_name = "eks_admin"
  create_role = true
  role_requires_mfa = false #### Multi-Factor Authentication
 
  custom_role_policy_arns = [module.allow_eks_access_iam_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]
}

module "user1_iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.55.0"

  name = "user1"
  create_iam_access_key = false
  create_iam_user_login_profile = false
 
  force_destroy = true
}

module "devops_iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.55.0"

  name = "devops"
  create_iam_access_key = true
  create_iam_user_login_profile = true
 
  force_destroy = false
}

module "allow_assume_eks_admins_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.55.0"

  name          = "allow-assume-eks-admin-iam-role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admins_iam_role.iam_role_arn
      },
    ]
  })
}

module "eks_admin_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.55.0"

  name = "eks-admin"
  attach_iam_self_management_policy = false

  create_group = true
  group_users = [module.devops_iam_user.iam_user_name]
  custom_group_policy_arns = [module.allow_assume_eks_admins_iam_policy.arn]
}

module "cluster_autoscaler_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.55.0"

  role_name = "cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_ids = [module.eks.cluster_id]

  oidc_providers = {
    provider_arn = module.eks.oidc_provider_arn
    namespace_service_accounts = ["kube-system:cluster-autoscaler"]
  }
}

module "aws_load_balancer_controller_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.55.0"

  role_name = "aws-load-balancer-controller"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}



