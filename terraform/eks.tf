module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = "microservices-cluster"
  cluster_version = "1.28"

  vpc_id     = "vpc-01f201a3451bd66ee"
  subnet_ids = [
    "subnet-09280e5dba4677e8b", # private-us-east-1a
    "subnet-0aca703d4fd720a4c", # private-us-east-1b
    "subnet-0bd1b68339eb6e1b8"  # private-us-east-1c
  ]

  eks_managed_node_groups = {
    main = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  tags = {
    Project = "microservices-platform"
  }
}