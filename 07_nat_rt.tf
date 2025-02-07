resource "aws_route_table" "sesac_natrt_a" {
  vpc_id = aws_vpc.sesac_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sesac_nat_public_a.id
  }

  tags = {
    Name = "${var.project_name}-natrt-a"
  }
}

resource "aws_route_table" "sesac_natrt_b" {
  vpc_id = aws_vpc.sesac_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sesac_nat_public_b.id
  }

  tags = {
    Name = "${var.project_name}-natrt-b"
  }
}
