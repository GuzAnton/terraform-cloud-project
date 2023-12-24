resource "aws_instance" "project-bastion" {
  ami = lookup(var.AMI, var.REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.cloud-project-key.key_name
  subnet_id = module.VPC.public_subnets[0]
  count = var.instance_count
  vpc_security_group_ids = [aws_security_group.project-bastion-sg.id]
  tags = {
    Name = "project-bastion"
    project = "project"
  }
}