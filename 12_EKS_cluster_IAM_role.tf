#  1. EKS Cluster IAM Role

resource "aws_iam_role" "eks_cluster_iam_role" { #aws_iam_role.eks_cluster_iam_role.id
  name = "eks-cluster-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# 2. IAM Role policy

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}

# 3. EKS Cluster

resource "aws_eks_cluster" "sesac_eks_cluster" {
  name     = "sesac-eks-cluster"
  role_arn =  aws_iam_role.eks_cluster_iam_role.arn
  version = "1.31"
#  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  vpc_config {
    security_group_ids = [aws_security_group.sesac-security-group-web.id]
    subnet_ids         = concat([aws_subnet.sesac_private_2a.id], [aws_subnet.sesac_private_2b.id]) # 두 개 이상 배열 결합
    endpoint_private_access = true # 동일 vpc 내 private ip간 통신허용
    endpoint_public_access = true #  vpc 외부에서 public ip간 통신허용
   }
  }

# 4. Node Group IAM Role

resource "aws_iam_role" "eks_node_iam_role" {
  name = "eks-node-iam-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# iam role policy

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_iam_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_iam_role.name
}
