# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 4.14"
      #version = ">= 4.65"
      version = ">= 5.10"
     }
    kubernetes = {
      source = "hashicorp/kubernetes"
      #version = "~> 2.11"
      version = ">= 2.20"
    }      
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "ethan-eks-perntodo"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1" 
 
  
  }  
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}