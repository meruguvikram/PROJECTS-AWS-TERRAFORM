# Create the backend
terraform {
  backend "s3" {
    bucket         = "rentzone-state-bucket-st"
    key            = "rentzone/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "rentozone-state-lock-table-st"
  }
}