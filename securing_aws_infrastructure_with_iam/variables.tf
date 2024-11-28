variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

# List of existing users for each group
variable "existing_developer_users" {
  type = list(string)
  default = [
    "developer-1",
    "developer-2",
    "developer-3",
    "developer-4"
  ]
}

variable "existing_operations_users" {
  type = list(string)
  default = [
    "operations-1",
    "operations-2"
  ]
}

variable "existing_finance_users" {
  type    = string
  default = "finances-1"
}

variable "existing_analyst_users" {
  type = list(string)
  default = [
    "analyst-1",
    "analyst-2",
    "analyst-3"
  ]
}

variable "password_length" {
  description = "Minimum password length"
  type        = number
  default     = 12
}

variable "password_max_age" {
  description = "Maximum password age in days"
  type        = number
  default     = 90
}

variable "password_reuse_prevention" {
  description = "Number of previous passwords to prevent reuse"
  type        = number
  default     = 3
}

variable "developers_managed_policies" {
  description = "List of managed policy ARNs for the developer group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
  ]
}

variable "operations_managed_policies" {
  description = "List of managed policy ARNs for infrastructure group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  ]
}

variable "finance_managed_policies" {
  description = "List of managed policy ARNs for finance group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}

variable "analyst_managed_policies" {
  description = "List of managed policy ARNs for the analyst group"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
  ]

}
