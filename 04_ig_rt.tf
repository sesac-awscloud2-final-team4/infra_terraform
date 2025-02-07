resource "aws_route_table" "sesac_rt" {
  vpc_id = aws_vpc.sesac_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sesac_ig.id
  }

  tags = {
    Name = "${var.project_name}-rt"
  }
}
