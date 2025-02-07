resource "aws_autoscaling_attachment" "sesac_autosgatt"{
  autoscaling_group_name = aws_autoscaling_group.sesac_autosg.id
  lb_target_group_arn = aws_lb_target_group.sesac_albtg.arn
}