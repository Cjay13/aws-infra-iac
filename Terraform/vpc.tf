module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecom-vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnets = ["10.0.5.0/25", "10.0.6.0./24"]

  create_database_subnet_group = true

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

}

module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "rds-sg"
  description = "Security group for rds instance"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access within the VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]
}