# role
data "aws_iam_policy_document" "instance_iam_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "instance_iam_role" {
  name               = "${var.project_name}-instance-iam-role"
  assume_role_policy = data.aws_iam_policy_document.instance_iam_role.json
}

# policy
data "aws_iam_policy" "instance_iam_policy" {
  name = "AmazonEC2ContainerServiceforEC2Role"
}

# attach
resource "aws_iam_role_policy_attachment" "instance_role-attach" {
  role       = aws_iam_role.instance_iam_role.name
  policy_arn = data.aws_iam_policy.instance_iam_policy.arn
}

# profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.instance_iam_role.name
}