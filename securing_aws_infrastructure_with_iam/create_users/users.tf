provider "aws" {
  region = "eu-west-2"
}
resource "aws_iam_user" "new_users" {
  for_each = toset([
    "developer-1",
    "developer-2",
    "developer-3",
    "developer-4",
    "operations-1",
    "operations-2",
    "finances-1",
    "analyst-1",
    "analyst-2",
    "analyst-3"
  ])
  name = each.key
}

output "created_users" {
  value       = [for user in aws_iam_user.new_users : user.name]
  description = "List of IAM users created by Terraform"
}
