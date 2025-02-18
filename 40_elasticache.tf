resource "aws_subnet" "sesac_cache_a" {
  vpc_id      = aws_vpc.sesac_vpc.id
  cidr_block  = "10.0.21.0/24"
  availability_zone = local.subnet_a

  tags = {
    Name = "sesac-cache-a"
  }
}

resource "aws_subnet" "sesac_cache_b" {
  vpc_id      = aws_vpc.sesac_vpc.id
  cidr_block  = "10.0.22.0/24"
  availability_zone = local.subnet_b

  tags = {
    Name = "sesac-cache-b"
  }
}

resource "aws_security_group" "redis_sg" {
  vpc_id = aws_vpc.sesac_vpc.id
  name   = "redis-security-group"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redis-security-group"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.sesac_cache_a.id, aws_subnet.sesac_cache_b.id]

  tags = {
    Name = "redis-subnet-group"
  }
}

resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = "sesac-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "param"
  engine_version       = "7.0"
  port                 = 6379

  security_group_ids  = [aws_security_group.redis_sg.id]
  subnet_group_name   = aws_elasticache_subnet_group.redis_subnet_group.name

  tags = {
    Name = "redis-cluster"
  }
}

resource "aws_elasticache_replication_group" "redis_replication" {
  replication_group_id       = "sesac-redis-replication"
  description                = "Redis replication group"
  engine                     = "redis"
  engine_version             = "7.0"
  node_type                  = "cache.t3.micro"
  num_cache_clusters         = 2
  parameter_group_name       = "default.redis7"
  port                       = 6379
  automatic_failover_enabled = true

  security_group_ids  = [aws_security_group.redis_sg.id]
  subnet_group_name   = aws_elasticache_subnet_group.redis_subnet_group.name

  tags = {
    Name = "redis-cluster-replication"
  }
}