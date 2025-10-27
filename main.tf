provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "sctp-ce12-tfstate"
    key    = "groupxyz-coaching16-tfstate.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "groupxyz-bucket" {
  # checkov:skip=CKV_AWS_145:Ensure that S3 buckets are encrypted with KMS by default - NA
  # checkov:skip=CKV2_AWS_62:Ensure S3 buckets should have event notifications enabled - NA
  # checkov:skip=CKV_AWS_18:Ensure the S3 bucket has access logging enabled - NA
  # checkov:skip=KV2_AWS_6:Ensure that S3 bucket has a Public Access block - NA
  # checkov:skip=CKV2_AWS_61:Ensure that an S3 bucket has a lifecycle configuration - NA
  # checkov:skip=CKV_AWS_21:Ensure all data stored in the S3 bucket have versioning enabled - NA
  # checkov:skip=CKV_AWS_144:Ensure that S3 bucket has cross-region replication enabled - NA
  # checkov:skip=CKV2_AWS_6:Ensure that S3 bucket has a Public Access block -NA
  bucket = "groupxyz-coaching16-test-bucket"
}