resource "aws_ecs_cluster" "sesac_test_cluster" {
  name = "sesac-test-cluster"

  service_connect_defaults {
    namespace = "arn:aws:servicediscovery:ap-northeast-2:448049822958:namespace/ns-3u26rtjxbktfruez"
  }
}

# resource "aws_ecs_task_definition" " " {
#   family                    = "sesac-ecs-task"
#   network_mode              = "bridge"
#   requires_compatibilities  = ["EC2"]
#   cpu                      = "512"
#   memory                   = "1024"
#
#   container_definitions = jsonencode([
#     {
#       name      = "sesac-container"
#       image     = "${data.aws_ecr_repository.sesac_ecr_repository.repository_url}:latest"
#       essential = true
#       cpu: 512,
#       memory: 1024,
#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#         }
#       ]
#     }
#   ])
# }

# resource "aws_ecs_service" "sesac_ecs_service" {
#   name            = "sesac-save-svc"
#   cluster         = aws_ecs_cluster.sesac_test_cluster.id
#   task_definition = aws_ecs_task_definition.sesac_ecs_task.arn
#   desired_count   = 2
#   iam_role        = aws_iam_role.instance_iam_role.arn
#
#   load_balancer {
#     target_group_arn = aws_lb_target_group.sesac_albtg.arn
#     container_name   = "sesac-container"
#     container_port   = 80
#   }
#
#   depends_on = [
#     aws_lb_listener.sesac_albli
#   ]
# }