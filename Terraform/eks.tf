module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.clusterName
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_enabled_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]

      min_size     = 2
      max_size     = 4
      desired_size = 3

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        ClusterAutoscalerPolicy = "arn:aws:iam::266735819216:policy/cluster-asg"
      }

      tags = {
        "k8s.io/cluster-autoscaler/enabled"         = "true"
        "k8s.io/cluster-autoscaler/ecom-eks" = "owned"
      }

    }

    two = {
      name           = "node-group-2"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        ClusterAutoscalerPolicy = "arn:aws:iam::266735819216:policy/cluster-asg"
      }

      tags = {
        "k8s.io/cluster-autoscaler/enabled"         = "true"
        "k8s.io/cluster-autoscaler/ecom-eks" = "owned"
      }

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
