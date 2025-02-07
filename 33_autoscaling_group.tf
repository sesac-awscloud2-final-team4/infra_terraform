resource "aws_autoscaling_group" "sesac_autosg" {
  name ="${var.project_name}-autoscale-group"
  min_size = 2
  max_size = 4
  desired_capacity = 2
  health_check_grace_period = 60
  health_check_type = "EC2"
  force_delete = false
  vpc_zone_identifier = [aws_subnet.sesac_private_2a.id, aws_subnet.sesac_private_2b.id]

  launch_template {
    id = aws_launch_template.web_app_launch_template.id
    version = "$Latest"
  }
}