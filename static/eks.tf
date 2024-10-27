module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "cluster-${local.resource_name}"
  cluster_version = "1.30"
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  iam_role_arn = "arn:aws:iam::992382545251:role/status-page-itay-noa"  # Updated line

  eks_managed_node_group_defaults = {
    ami_type    = "AL2_x86_64"
    iam_role_arn = "arn:aws:iam::992382545251:role/status-page-node-itay-noa"
    subnet_ids = var.private_subnets
  }

  eks_managed_node_groups = {
    one = {
      name            = "ng-1-${local.resource_name}"
      instance_types  = ["t2.large"]
      min_size        = 1
      max_size        = 5
      desired_size    = 1
      tags            = local.billing_tags
    }
    two = {
      name            = "ng-2-${local.resource_name}"
      instance_types  = ["t2.large"]
      min_size        = 1
      max_size        = 5
      desired_size    = 1
      tags            = local.billing_tags
    }
  }

 cluster_security_group_id = aws_security_group.eks_sg.id

  tags = local.billing_tags
}

# Add-ons for EKS cluster

resource "aws_eks_addon" "kube_proxy" {
  cluster_name              = module.eks.cluster_name
  addon_name                = "kube-proxy"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name              = module.eks.cluster_name
  addon_name                = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name              = module.eks.cluster_name
  addon_name                = "coredns"
}
