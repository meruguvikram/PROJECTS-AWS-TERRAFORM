provider "aws" {
  region = "eu-south-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "cloudspace-consulting-state-bucket-st"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "cloudspace-consulting-lock-table-st"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}