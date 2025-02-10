provider "aws" {
  region = "<your region>"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "cea-projects-terraform-state"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}