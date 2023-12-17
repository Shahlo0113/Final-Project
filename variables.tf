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
    Bastion_Host_name = string,
    subnet_id         = string
  }))
  default = {
  }
}

variable "security_groups" {
  description = "A map of security groups with their rules"
  type = map(object({
    description = string
    ingress_rules = optional(list(object({
      description = optional(string)
      priority    = optional(number)
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })))
    egress_rules = list(object({
      description = optional(string)
      priority    = optional(number)
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}