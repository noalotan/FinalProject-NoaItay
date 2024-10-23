module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "cluster-${local.resource_name}"
  cluster_version = "1.30"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = data.terraform_remote_state.static.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.static.outputs.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "ng-1-${local.resource_name}"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
      tags = local.billing_tags
    }

    two = {
      name = "ng-2-${local.resource_name}"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
      tags = local.billing_tags
    }
  }
  tags = local.billing_tags
}
