data "aws_ami" "sesac_ec2_ami" {
  most_recent	= true

  filter {
    name	= "name"
    values  = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
  filter {
    name	= "virtualization-type"
    values	= ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

locals {
  instance_type = "t3.medium"
}

resource "aws_launch_template" "web_app_launch_template" {
  name					= "${var.project_name}-ecs-launch-template"
  image_id				= data.aws_ami.sesac_ec2_ami.id
  instance_type			= local.instance_type
  key_name				= aws_key_pair.project-key.key_name
  vpc_security_group_ids	= [aws_security_group.sesac_security_group_web.id]

  iam_instance_profile	{
    name = aws_iam_instance_profile.instance_profile.name
  }
}