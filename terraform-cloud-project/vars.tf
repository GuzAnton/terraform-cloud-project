variable "REGION" {
  default = "eu-central-1"
}

variable "AMI" {
  type = map(any)
  default = {
    eu-central-1 = "ami-06dd92ecc74fdfb36"
    eu-west-1 = "ami-0694d931cee176e7d"
  }
}
variable "PUB_KEY_PATH" {
  default = "test.pub"
}

variable "PRIV_KEY_PATH" {
  default = "test"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MyIp" {
  default = "176.36.180.171/32"
}