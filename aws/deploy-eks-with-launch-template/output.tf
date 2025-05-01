output "kubeconfig" {
  value = aws_eks_cluster_auth.cluster_auth.kubeconfig
}
