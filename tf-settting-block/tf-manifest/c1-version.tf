#terraform block(provider requirement)
terraform {
    required_version = "~> 1.13"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.10"
        }
    }
}

#provider block (provider configuration)
provider "aws" {
  #alias   = "training"
  profile = "account2"
  region  = var.aws_region
}
