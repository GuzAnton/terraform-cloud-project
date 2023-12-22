resource "aws_security_group" "Project_beanstalk_elb_sg" {
  name = "Project_bs_elb_sg"
  description = "Security group for beanstack_elb"
  vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_security_group" "Project_Bastion_sg" {
  name = "Project_Bastion_Sg"
  description = "Security group for Bastion Host"
  vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.MyIp]
  }
}

resource "aws_security_group" "Project_prod_sg" {
    name = "EC2-SG"
    description = "Security group for ec2"
    vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.Project_Bastion_sg.id]
  }
}

resource "aws_security_group" "Project_backend_sg" {
    name = "Project_backend_sg"
    description = "Security group for backend resources(RDS,active MQ, elastic cache)"
    vpc_id = module.VPC.vpc_id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [aws_security_group.Project_prod_sg.id]
  }
}

resource "aws_security_group_rule" "Project_InboundTraffic_rule" {
  type = "ingress"
  from_port = 0
  to_port = 65536
  protocol = "tcp"
  security_group_id = aws_security_group.Project_backend_sg.id
  source_security_group_id = aws_security_group.Project_backend_sg.id
}