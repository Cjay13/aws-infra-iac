terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "~> 2.27.0"
    }
  }

  backend "s3" {
    bucket = "cj-vprofile-s3-storage"
    key    = "terraform.ecom-tfstate"
    region = "us-east-1"
  }
}