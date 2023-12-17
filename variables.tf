variable "prefix" {
  type    = string
  default = "final"
}

variable "public_subnets_BS" {
  type = map(object({
    Bastion_Host_name = string
    cidr_block        = string
    availability_zone = string
  }))

  default = {
  }
}

variable "Bastion_Host_ec2" {
  type = map(object({
    server_name = string,
    subnet_id   = string
  }))
  default = {
  }
}