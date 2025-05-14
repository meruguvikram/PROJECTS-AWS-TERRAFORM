data "aws_availability_zones" "available_zones" {}

resource "aws_vpc" "demo-vpc-a" {
  cidr_block = var.demo_vpc_a_cidr
  tags       = { Name = "demo-vpc-a" }

  enable_dns_support = true  
  enable_dns_hostnames = true  

}

resource "aws_vpc" "demo-vpc-b" {
  cidr_block = var.demo_vpc_b_cidr
  tags       = { Name = "demo-vpc-b" }

  enable_dns_support = true  
  enable_dns_hostnames = true  
  
}

resource "aws_subnet" "demo-subnet-a" {
  vpc_id            = aws_vpc.demo-vpc-a.id
  cidr_block        = var.demo_subnet_a_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags              = { Name = "subnet-a" }
}

resource "aws_subnet" "demo-subnet-b" {
  vpc_id            = aws_vpc.demo-vpc-b.id
  cidr_block        = var.demo_subnet_b_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  tags              = { Name = "subnet-b" }
}

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc-a.id
}

resource "aws_route_table" "demo-route-table-a" {
  vpc_id = aws_vpc.demo-vpc-a.id
}

resource "aws_route_table" "demo-route-table-b" {
  vpc_id = aws_vpc.demo-vpc-b.id
}

resource "aws_route_table_association" "assoc-a" {
  subnet_id      = aws_subnet.demo-subnet-a.id
  route_table_id = aws_route_table.demo-route-table-a.id
}

resource "aws_route_table_association" "assoc-b" {
  subnet_id      = aws_subnet.demo-subnet-b.id
  route_table_id = aws_route_table.demo-route-table-b.id
}

resource "aws_route" "internet-access" {
  route_table_id         = aws_route_table.demo-route-table-a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo-igw.id
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id      = aws_vpc.demo-vpc-a.id
  peer_vpc_id = aws_vpc.demo-vpc-b.id
  auto_accept = true
  tags        = { Name = "vpc-a-to-b" }
}

resource "aws_vpc_peering_connection_options" "requester" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "peering-a-to-b" {
  route_table_id            = aws_route_table.demo-route-table-a.id
  destination_cidr_block    = aws_vpc.demo-vpc-b.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "peering-b-to-a" {
  route_table_id            = aws_route_table.demo-route-table-b.id
  destination_cidr_block    = aws_vpc.demo-vpc-a.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}
