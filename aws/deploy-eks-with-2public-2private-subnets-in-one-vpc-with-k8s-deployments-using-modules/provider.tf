provider "kubernetes" {
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authoriy[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks","get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command = "aws"
  }
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command = "aws"
    
    # In CLI, running "aws eks get-token --cluster <eks_cluster_id>"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
      command     = "aws"
    }
  }
}

