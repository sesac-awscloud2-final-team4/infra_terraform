resource "aws_internet_gateway" "sesac_ig" {
  vpc_id = aws_vpc.sesac_vpc.id

  tags = {
    Name = "${var.project_name}-ig"
  }
}
