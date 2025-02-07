data "aws_availability_zones" "available" {}

locals {
  subnet_a = data.aws_availability_zones.available.names[0]
  subnet_b = data.aws_availability_zones.available.names[1]
}

resource "aws_subnet" "sesac_public_a" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = local.subnet_a

  tags = {
    Name = "${var.project_name}-public-a"
  }
}

resource "aws_subnet" "sesac_public_b" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = local.subnet_b

  tags = {
    Name = "${var.project_name}-public-b"
  }
}

resource "aws_subnet" "sesac_private_2a" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = local.subnet_a

  tags = {
    Name = "${var.project_name}-private-2a"
  }
}

resource "aws_subnet" "sesac_private_2b" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = local.subnet_b

  tags = {
    Name = "${var.project_name}-private-2b"
  }
}

resource "aws_subnet" "sesac_db_2a" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = local.subnet_a

  tags = {
    Name = "${var.project_name}-db-2a"
  }
}

resource "aws_subnet" "sesac_db_2b" {
  vpc_id     = aws_vpc.sesac_vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = local.subnet_b

  tags = {
    Name = "${var.project_name}-db-2b"
  }
}