terraform {
  required_providers {
    aws = ">=3.5.4"
  }

  backend "s3" {
    bucket = "kafka-journey"
    key = "terraform.tfstate"
    region = "sa-east-1"
  }
}

provider "aws" {
  region = "sa-east-1"
}