resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.sesac_eks_cluster.name
  node_group_name = "worker-node-group"
  node_role_arn   = aws_iam_role.eks_node_iam_role.arn
  subnet_ids      = concat([aws_subnet.sesac_private_2a.id], [aws_subnet.sesac_private_2b.id])
  instance_types  = ["t3.micro"]  
  capacity_type   = "ON_DEMAND"
  
  remote_access {
    ec2_ssh_key = "project-key"  # SSH 키가 존재하는지 확인
  }

  labels = {
    "role" = "eks_node_iam_role"
  }

  scaling_config {
    desired_size = 10
    min_size     = 10
    max_size     = 20
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
