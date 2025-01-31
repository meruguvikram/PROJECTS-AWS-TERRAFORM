provider "aws" {
  region = var.region
}

# Additional provider for us-east-1, used for CloudFront WAF resources
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket       = "cea-projects-terraform-state"
    key          = "global/s3/terraform.tfstate"
    region       = "<your region>"
    encrypt      = true
    use_lockfile = true 
  }
}

# IAM Policy for Terraform to access the S3 backend
resource "aws_iam_policy" "terraform_s3_policy" {
  name        = "TerraformS3StatePolicy"
  description = "IAM Policy for Terraform state locking in S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::cea-projects-terraform-state-st",
          "arn:aws:s3:::cea-projects-terraform-state-st/global/s3/terraform.tfstate",
          "arn:aws:s3:::cea-projects-terraform-state-st/global/s3/terraform.tfstate.tflock"
        ]
      }
    ]
  })
}

# Attach the IAM Policy directly to a specific IAM User
resource "aws_iam_user_policy_attachment" "attach_policy_user" {
  user       = "<your IAM username>"
  policy_arn = aws_iam_policy.terraform_s3_policy.arn
}
