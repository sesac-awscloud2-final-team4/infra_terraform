resource "aws_route_table" "sesac_dbrt" {
  vpc_id = aws_vpc.sesac_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "database-subnet-rt"
  }
}
