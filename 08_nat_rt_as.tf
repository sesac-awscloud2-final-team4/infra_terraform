resource "aws_route_table_association" "sesac_natrtas_private_a" {
  subnet_id      = aws_subnet.sesac_private_a.id
  route_table_id = aws_route_table.sesac_natrt_a.id
}

resource "aws_route_table_association" "sesac_natrtas_private_b" {
  subnet_id      = aws_subnet.sesac_private_b.id
  route_table_id = aws_route_table.sesac_natrt_b.id
}