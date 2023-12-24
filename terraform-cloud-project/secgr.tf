resource "aws_security_group" "project-beanstalk-elb-sg" {
  name        = "project-bs-elb-sg"
  description = "Security group for beanstack_elb"
  vpc_id      = module.VPC.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "project-bastion-sg" {
  name        = "project-bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = module.VPC.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MyIp]
  }
}

resource "aws_security_group" "project-prod-sg" {
  name        = "project-prod-sg"
  description = "Security group for ec2"
  vpc_id      = module.VPC.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.project-bastion-sg.id]
  }
}

resource "aws_security_group" "project-backend-sg" {
  name        = "project-backend-sg"
  description = "Security group for backend resources(RDS,active MQ, elastic cache)"
  vpc_id      = module.VPC.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.project-prod-sg.id]
  }
}

resource "aws_security_group_rule" "project-inboundtraffic-rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.project-backend-sg.id
  source_security_group_id = aws_security_group.project-backend-sg.id
}