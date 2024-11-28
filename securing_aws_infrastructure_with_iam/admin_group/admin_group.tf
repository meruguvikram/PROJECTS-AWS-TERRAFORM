provider "aws" {
  region = "eu-west-2"
}

# Create an IAM Group
resource "aws_iam_group" "admin_group" {
  name = "AdminGroup"
}

# Attach AdministratorAccess Policy to the Group
resource "aws_iam_group_policy_attachment" "admin_policy_attachment" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create an IAM User
resource "aws_iam_user" "admin_user" {
  name = "admin_user1"
}

# Request user to reset password on next login
resource "aws_iam_user_login_profile" "admin_user_login_profile" {
  user                    = aws_iam_user.admin_user.name
  password_reset_required = true
}

# Password Policy
resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = 12
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 3
}

# Create a json document to deny access to all actions if MFA is not enabled
data "aws_iam_policy_document" "require_mfa" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}

# Create a policy from that document
resource "aws_iam_policy" "mfa_policy" {
  name   = "RequireMFA"
  policy = data.aws_iam_policy_document.require_mfa.json
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "admin_user_mfa_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = aws_iam_policy.mfa_policy.arn
}

# Add IAM User to the Group
resource "aws_iam_user_group_membership" "admin_group_membership" {
  user = aws_iam_user.admin_user.name
  groups = [
    aws_iam_group.admin_group.name,
  ]
}
