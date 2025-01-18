resource "aws_route_table_association" "sesac_dbrtas_dba" {
  subnet_id      = aws_subnet.sesac_db_2a.id
  route_table_id = aws_route_table.sesac_dbrt.id
}

resource "aws_route_table_association" "sesac_dbrtas_dbc" {
  subnet_id      = aws_subnet.sesac_db_2b.id
  route_table_id = aws_route_table.sesac_dbrt.id
}
