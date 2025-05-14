data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ec2_a" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.demo-subnet-a.id
  vpc_security_group_ids = [aws_security_group.sg_vpc_a.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name

  tags = { Name = "ec2-vpc-a" }
}

resource "aws_instance" "ec2_b" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.demo-subnet-b.id
  vpc_security_group_ids = [aws_security_group.sg_vpc_b.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name

  tags = { Name = "ec2-vpc-b" }
}
