provider "aws" {
  region = "us-east-2"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = "my-eks-cluster"

  # ✅ Enable public access so kubectl works from your laptop
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # ✅ Replace these with your actual values
  vpc_id     = "vpc-074bae621786b8360"
  subnet_ids = ["subnet-0e3712730a5dc1dbf", "subnet-0100ae25680412bc7"]

  # ✅ Node group
  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 2
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  # ✅ THIS FIXES YOUR ACCESS ISSUE (VERY IMPORTANT)
  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::022691691243:user/eks-admin-user"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}
