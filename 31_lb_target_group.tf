resource "aws_lb_target_group" "sesac_albtg" {
  name ="${var.project_name}-albtg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.sesac_vpc.id
  target_type = "instance"

  health_check {
    enabled = true
    healthy_threshold = 3
    matcher = "200"
    path = "/health.html"
    port = "traffic-port"
    protocol = "HTTP"

    timeout = 2
    unhealthy_threshold =3
  }
}

resource "aws_lb_listener" "sesac_albli" {
  load_balancer_arn = aws_lb.sesac_alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn=aws_lb_target_group.sesac_albtg.arn
  }
}