resource "aws_dynamodb_table" "recipes" {
  name         = "recipes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "recipes"
  }
}

# Define a DynamoDB VPC endpoint
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.eu-west-2.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [
    aws_route_table.private_route_table_az1.id,
    aws_route_table.private_route_table_az2.id
  ]
}