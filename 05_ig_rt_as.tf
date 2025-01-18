resource "aws_route_table_association" "sesac_rtas_public_a" {
  subnet_id      = aws_subnet.sesac_public_a.id
  route_table_id = aws_route_table.sesac_rt.id
}

resource "aws_route_table_association" "sesac_rtas_public_b" {
  subnet_id      = aws_subnet.sesac_public_b.id
  route_table_id = aws_route_table.sesac_rt.id
}
