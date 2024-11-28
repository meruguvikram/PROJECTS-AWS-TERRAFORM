# Group Memberships Mapping
output "group_memberships" {
  value = {
    developers = aws_iam_group_membership.developer_membership.users
    operations = aws_iam_group_membership.operations_membership.users
    finance    = aws_iam_group_membership.finance_membership.users
    analysts   = aws_iam_group_membership.analyst_membership.users
  }
  description = "Mapping of groups to their respective users."
}

# Aggregated MFA Enforced Users
output "mfa_enforced_users" {
  value = concat(
    var.existing_developer_users,
    var.existing_operations_users,
    [var.existing_finance_users],
    var.existing_analyst_users
  )
  description = "List of IAM users with MFA enforcement enabled."
}

# Password policy
output "password_policy_details" {
  value = {
    minimum_password_length   = aws_iam_account_password_policy.password_policy.minimum_password_length
    require_uppercase         = aws_iam_account_password_policy.password_policy.require_uppercase_characters
    require_lowercase         = aws_iam_account_password_policy.password_policy.require_lowercase_characters
    require_numbers           = aws_iam_account_password_policy.password_policy.require_numbers
    require_symbols           = aws_iam_account_password_policy.password_policy.require_symbols
    password_reuse_prevention = aws_iam_account_password_policy.password_policy.password_reuse_prevention
    max_password_age          = aws_iam_account_password_policy.password_policy.max_password_age
  }
  description = "Details of the IAM account password policy."
}
