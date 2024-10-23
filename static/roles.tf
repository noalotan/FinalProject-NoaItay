# EKS Cluster Role
resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-itay-noa"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]  # Allow EKS to assume this role
    }
  }
}

resource "aws_iam_policy_attachment" "eks_cluster_policy" {
  name       = "eks-cluster-policy-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_policy_attachment" "eks_vpc_resource_controller_policy" {
  name       = "eks-vpc-resource-controller-attachment"
  roles      = [aws_iam_role.eks_cluster_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_VPC_Resource_Controller"
}

# EKS Node Role
resource "aws_iam_role" "eks_node_role" {
  name               = "eks-nodee-role-itay-noa"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]  # Allow EC2 instances to assume this role
    }
  }
}

resource "aws_iam_policy_attachment" "eks_worker_node_policy" {
  name       = "eks-worker-node-policy-attachment"
  roles      = [aws_iam_role.eks_node_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_policy_attachment" "eks_cni_policy" {
  name       = "eks-cni-policy-attachment"
  roles      = [aws_iam_role.eks_node_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}
