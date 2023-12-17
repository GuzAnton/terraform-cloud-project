module "VPC" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.VPC_NAME
  cidr = var.Vpc_CIDR
  azs = [var.ZONE-a, var.ZONE-b, var.ZONE-c]
  private_subnets = [var.PrivSub-1, var.PrivSub-2, var.PrivSub-3]
  public_subnets = [var.PubSub-1, var.PubSub-2, var.PubSub-3]
  
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    Name = var.VPC_NAME
  }
}
