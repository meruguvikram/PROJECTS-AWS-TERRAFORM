# Region
variable "region" {
  type        = string
  description = "Region"
}

variable "demo_vpc_a_cidr" {
  type        = string
  description = "CIDR of VPC A"
}

variable "demo_vpc_b_cidr" {
  type        = string
  description = "CIDR of VPC B"
}

variable "demo_subnet_a_cidr" {
  type        = string
  description = "CIDR of demo subnet A"
}

variable "demo_subnet_b_cidr" {
  type        = string
  description = "CIDR of demo subnet B"
}
