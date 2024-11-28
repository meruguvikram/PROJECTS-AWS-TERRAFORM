provider "aws" {
  region = var.region
}

# Create new groups
resource "aws_iam_group" "developer" {
  name = "developers"
}

resource "aws_iam_group" "operations" {
  name = "operations"
}

resource "aws_iam_group" "finance" {
  name = "finance"
}

resource "aws_iam_group" "analyst" {
  name = "analysts"
}

# Request users to reset their password on next login
resource "aws_iam_user_login_profile" "developer_users" {
  count                   = length(var.existing_developer_users)
  user                    = var.existing_developer_users[count.index]
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "operations_users" {
  count                   = length(var.existing_operations_users)
  user                    = var.existing_operations_users[count.index]
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "finance_user" {
  user                    = var.existing_finance_users
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "analyst_users" {
  count                   = length(var.existing_analyst_users)
  user                    = var.existing_analyst_users[count.index]
  password_reset_required = true
}

# Attach existing users to groups
resource "aws_iam_group_membership" "developer_membership" {
  name  = "developer-group-membership"
  group = aws_iam_group.developer.name
  users = var.existing_developer_users
}

resource "aws_iam_group_membership" "operations_membership" {
  name  = "operations-group-membership"
  group = aws_iam_group.operations.name
  users = var.existing_operations_users
}

resource "aws_iam_group_membership" "finance_membership" {
  name  = "finance-group-membership"
  group = aws_iam_group.finance.name
  users = [var.existing_finance_users]
}

resource "aws_iam_group_membership" "analyst_membership" {
  name  = "analyst-group-membership"
  group = aws_iam_group.analyst.name
  users = var.existing_analyst_users
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
  name   = "RequireMFAPolicy"
  policy = data.aws_iam_policy_document.require_mfa.json
}

# Attach the policy to the users
resource "aws_iam_user_policy_attachment" "developer_mfa" {
  for_each   = toset(var.existing_developer_users)
  user       = each.key
  policy_arn = aws_iam_policy.mfa_policy.arn
}

resource "aws_iam_user_policy_attachment" "operations_mfa" {
  for_each   = toset(var.existing_operations_users)
  user       = each.key
  policy_arn = aws_iam_policy.mfa_policy.arn
}

resource "aws_iam_user_policy_attachment" "finance_mfa" {
  for_each   = toset([var.existing_finance_users])
  user       = each.key
  policy_arn = aws_iam_policy.mfa_policy.arn
}

resource "aws_iam_user_policy_attachment" "analyst_mfa" {
  for_each   = toset(var.existing_analyst_users)
  user       = each.key
  policy_arn = aws_iam_policy.mfa_policy.arn
}

# Password Policy
resource "aws_iam_account_password_policy" "password_policy" {
  minimum_password_length        = var.password_length
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  allow_users_to_change_password = true
  max_password_age               = var.password_max_age
  password_reuse_prevention      = var.password_reuse_prevention
}

# Attach the policies to the IAM groups
resource "aws_iam_group_policy_attachment" "developers" {
  count      = length(var.developers_managed_policies)
  group      = aws_iam_group.developer.name
  policy_arn = var.developers_managed_policies[count.index]
}

resource "aws_iam_group_policy_attachment" "operations" {
  count      = length(var.operations_managed_policies)
  group      = aws_iam_group.operations.name
  policy_arn = var.operations_managed_policies[count.index]
}

resource "aws_iam_group_policy_attachment" "finance" {
  count      = length(var.finance_managed_policies)
  group      = aws_iam_group.finance.name
  policy_arn = var.finance_managed_policies[count.index]
}

resource "aws_iam_group_policy_attachment" "analyst" {
  count      = length(var.analyst_managed_policies)
  group      = aws_iam_group.analyst.name
  policy_arn = var.analyst_managed_policies[count.index]
}