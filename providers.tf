terraform {
  cloud {
    organization = "summercloud"

    workspaces {
      name = "final-project"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}
provider "aws" {
  region = "us-east-1"
}