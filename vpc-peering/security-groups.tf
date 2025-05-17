resource "aws_security_group" "sg_vpc_a" {
  name   = "vpc-a-sg"
  vpc_id = aws_vpc.demo-vpc-a.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "VPC A SG" }
}

resource "aws_security_group" "sg_vpc_b" {
  name   = "vpc-b-sg"
  vpc_id = aws_vpc.demo-vpc-b.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "VPC B SG" }
}

# Ingress Rule: Allow sg_vpc_b to SSH into instances in sg_vpc_a
resource "aws_security_group_rule" "allow_b_to_a" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_vpc_a.id
  source_security_group_id = aws_security_group.sg_vpc_b.id
}

# Ingress Rule: Allow sg_vpc_a to SSH into instances in sg_vpc_b
resource "aws_security_group_rule" "allow_a_to_b" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_vpc_b.id
  source_security_group_id = aws_security_group.sg_vpc_a.id
}
