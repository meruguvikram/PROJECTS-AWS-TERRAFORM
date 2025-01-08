# Configure AWS provider to establish a secure connection between Terraform and AWS
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Automation"  = "terraform"
      "Project"     = var.project_name
      "Environment" = var.environment
    }
  }
}

# Configure Terraform backend for state management
terraform {
  backend "s3" {
    bucket         = "cloudspace-consulting-state-bucket-st"
    key            = "global/terraform.tfstate"
    region         = "eu-south-2"
    dynamodb_table = "cloudspace-consulting-lock-table-st"
  }
}
