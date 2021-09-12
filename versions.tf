terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.58.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }

  required_version = ">= 1.0.6"
}
