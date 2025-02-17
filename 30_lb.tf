resource "aws_lb" "sesac_alb" {
  name = "${var.project_name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.sesac_security_group_alb_web.id]
  subnets = [aws_subnet.sesac_public_a.id,aws_subnet.sesac_public_b.id]
  tags = {
    Name = "${var.project_name}-alb"
  }
}