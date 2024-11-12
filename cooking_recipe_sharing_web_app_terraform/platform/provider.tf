provider "aws" {
    region = "your region"
}

# Additional provider for us-east-1, used for CloudFront WAF resources
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "your bucket name"
    key            = "global/s3/terraform.tfstate"
    region         = "your region"
    dynamodb_table = "your dynamodb table name"
  }
}