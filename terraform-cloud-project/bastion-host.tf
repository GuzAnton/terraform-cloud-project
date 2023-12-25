resource "aws_instance" "project-bastion" {
  ami                         = lookup(var.AMI, var.REGION)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.cloud-project-key.key_name
  subnet_id                   = module.VPC.public_subnets[0]
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.project-bastion-sg.id]
  associate_public_ip_address = true
  tags = {
    Name    = "project-bastion"
    project = "project"
  }
  provisioner "file" {
    content     = templatefile("db-deploy.tmpl", { rds-endpoint = aws_db_instance.project-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/project-dbdeploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/project-dbdeploy.sh",
      "sudo /tmp/project-dbdeploy.sh"
    ]
  }
  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.project-rds]
}  