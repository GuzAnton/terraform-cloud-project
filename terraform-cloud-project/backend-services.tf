resource "aws_db_subnet_group" "Project_RDS_subgr" {
  name       = "main"
  subnet_ids = [module.VPC.private_subnets[0], module.VPC.private_subnets[1], module.VPC.private_subnets[2]]
  tags = {
    Name = " Subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "Project_Elasticcache_subgr" {
  name       = "Project elastic cache"
  subnet_ids = [module.VPC.private_subnets[0], module.VPC.private_subnets[1], module.VPC.private_subnets[2]]
}

resource "aws_db_instance" "Project_RDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.6.34"
  instance_class         = "db.t2.micro"
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.6"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.Project_RDS_subgr.name
  vpc_security_group_ids = [aws_security_group.Project_backend_sg.id]
}

resource "aws_elasticache_cluster" "Project_cache" {
  cluster_id           = "project-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.5"
  port                 = 11211
  security_group_ids   = [aws_security_group.Project_backend_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.Project_Elasticcache_subgr.name
}

resource "aws_mq_broker" "Project_MQ" {
  broker_name        = "project-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.Project_backend_sg.id]
  subnet_ids         = [module.VPC[0]]
  user {
    username = var.rmquser
    password = var.rmqpass
  }
}