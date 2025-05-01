resource "aws_eks_cluster" "mylocalone_k8s_cluster" {
  name = "mylocalone-k8s-cluster"
  role_arn = "aws_iam_role.eks_cluster_role.arn"
  version = "1.31"
  vpc_config {
    subnet_ids = [
      aws_subnet.mylocalone_subnet_private_a.id,
      aws_subnet.mylocalone_subnet_private_b.id
    ]
  }
}

resource "aws_eks_node_group" "mylocalone_k8s_cluster_nodegroup_one" {
  cluster_name    = aws_eks_cluster.mylocalone_k8s_cluster.name
  node_group_name = "nodegroup_one"
  node_role_arn   = aws_iam_role.eks_node_role.arn
}

resource "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.mylocalone_k8s_cluster.name

  depends_on = [
    aws_eks_cluster.mylocalone_k8s_cluster,
    aws_eks_node_group.mylocalone_k8s_cluster_nodegroup_one
  ]
}


