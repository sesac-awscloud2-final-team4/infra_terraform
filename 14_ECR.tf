resource "aws_ecr_repository" "sesac_ecr_repository" {
  name                 = "sesac-ecr-repository"  # ECR 리포지토리 이름
  image_tag_mutability = "MUTABLE"      # 이미지 태그 가변성 설정

  tags = {
    Name        = "sesac-ecr-repository"
    Environment = "Production"
  }

  lifecycle {
    prevent_destroy = false  # 리포지토리 삭제 가능
  }
}

output "vpc_name" {
  value = aws_vpc.sesac_vpc.id
}