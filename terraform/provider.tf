terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    opensearch = {
      source  = "opensearch-project/opensearch"
      version = "~> 2.3"
    }
  }

  backend "s3" {
    bucket       = "opensearch-brinson-tfstate"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}

provider "opensearch" {
  url = "https://${aws_opensearch_domain.main.endpoint}"

  username = var.opensearch_username
  password = var.opensearch_password

  sign_aws_requests = false

  healthcheck = false
}

data "aws_caller_identity" "current" {}