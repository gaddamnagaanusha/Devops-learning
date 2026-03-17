terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"
    }
  }

backend "s3" {
    bucket   = "remote-state-joindevops"
    key            = "locals-demo.tfstate"  #key value is unique for each environment
    region         = "us-east-1"
    encrypt        = true
    use_lockfile = true   # Enables S3-managed locking
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  
}