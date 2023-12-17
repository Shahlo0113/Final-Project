resource "aws_vpc" "vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

variable "bastion_host_ec2" {
  type = map(object({
    _name     = string,
    subnet_id = string
  }))
  default = {
  }
}