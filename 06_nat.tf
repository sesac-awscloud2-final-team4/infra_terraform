resource "aws_eip" "sesac_eip_nat_a" {
  domain = "vpc"
}
resource "aws_eip" "sesac_eip_nat_b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "sesac_nat_public_a" {
  allocation_id = aws_eip.sesac_eip_nat_a.id
  subnet_id     = aws_subnet.sesac_public_a.id

  tags = {
    Name = "${var.project_name}-nat-public-a"
  }
}

resource "aws_nat_gateway" "sesac_nat_public_b" {
  allocation_id = aws_eip.sesac_eip_nat_b.id
  subnet_id     = aws_subnet.sesac_public_b.id

  tags = {
    Name = "${var.project_name}-nat-public-b"
  }
}
