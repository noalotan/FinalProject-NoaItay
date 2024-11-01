module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "cluster-${local.resource_name}"
  cluster_version = "1.30"
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  iam_role_arn = "arn:aws:iam::992382545251:role/status-page-itay-noa"

  eks_managed_node_group_defaults = {
    ami_type    = "AL2_x86_64"
    iam_role_arn = "arn:aws:iam::992382545251:role/status-page-node-itay-noa"
    subnet_ids = var.private_subnets
  }

  eks_managed_node_groups = {
    main = {
      name            = "ng-main-${local.resource_name}"
      instance_types  = ["t2.large"]
      min_size        = 2  # Minimum size for the node group
      max_size        = 5  # Maximum size for autoscaling
      desired_size    = 2  # Desired size for initial deployment
      tags            = local.billing_tags
    }
  }

  tags = local.billing_tags
}

# Add-ons for EKS cluster
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = module.eks.cluster_name
  addon_name   = "kube-proxy"

  depends_on = [module.eks]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = module.eks.cluster_name
  addon_name   = "vpc-cni"

  depends_on = [module.eks]
}

resource "aws_eks_addon" "coredns" {
  cluster_name = module.eks.cluster_name
  addon_name   = "coredns"

  depends_on = [module.eks]
}

# EKS Cluster Security Group Output
output "eks_cluster_security_group_id" {
  value       = module.eks.cluster_security_group_id
  description = "The security group ID associated with the EKS cluster."
}

# Ingress Rule for HTTPS traffic from a specific security group
resource "aws_security_group_rule" "allow_https_from_sg" {
  type                     = "ingress"
  from_port               = 443
  to_port                 = 443
  protocol                = "tcp"
  security_group_id       = module.eks.cluster_security_group_id  # Use the cluster's SG ID
  source_security_group_id = "sg-00517b0aa62592c6d"  # Allow traffic from this SG

  description = "Allow HTTPS traffic from specified security group"
}
