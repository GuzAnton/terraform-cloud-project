variable "REGION" {
  default = "eu-central-1"
}

variable "AMI" {
  type = map(any)
  default = {
    eu-central-1 = "ami-06dd92ecc74fdfb36"
    eu-west-1    = "ami-0694d931cee176e7d"
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

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "addmiin122112"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbuser" {
  default = "admin"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "Project-VPC"
}

variable "ZONE-a" {
  default = "eu-central-1a"
}

variable "ZONE-b" {
  default = "eu-central-1b"
}

variable "ZONE-c" {
  default = "eu-cenral-1c"
}

variable "VpcCIDR" {
  default = "172.21.0.0/16"
}

variable "PubSub-1" {
  default = "172.21.1.0/24"
}

variable "PubSub-2" {
  default = "172.21.2.0/24"
}

variable "PubSub-3" {
  default = "172.21.3.0/24"
}

variable "PrivSub-1" {
  default = "172.21.4.0/24"
}

variable "PrivSub-2" {
  default = "172.21.5.0/24"
}

variable "PrivSub-3" {
  default = "172.21.6.0/24"
}