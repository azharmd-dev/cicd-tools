terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.28.0"
    }
  }
  backend "s3" {
    bucket = "robomart"
    key    = "robomart-dev-jenkins"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true

  }
}

provider "aws" {
  # Configuration options
}