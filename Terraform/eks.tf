module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.clusterName
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = "t3.small"

      min_size     = 1
      max_size     = 3
      desired_size = 2

    }

    two = {
      name           = "node-group-2"
      instance_types = "t3.small"

      min_size     = 1
      max_size     = 2
      desired_size = 1

    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = {
    name    = var.clusterName
    project = "Cjay-Ecom"
  }
}