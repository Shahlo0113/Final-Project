public_subnets_BS = {
  bastion_host_1 = {
    name              = "BASTION_HOST_1",
    cidr_block        = "172.16.0.0/24"
    availability_zone = "us-east-1a"
  },
  bastion_host_2 = {
    name              = "BASTION_HOST_2",
    cidr_block        = "172.16.1.0/24"
    availability_zone = "us-east-1b"
  }
}

Bastion_Host_ec2 = {
  bastion_host_1 = {
    Bastion_Host_name = "BASTION_HOST_1",
    subnet_id   = ""

  },
  bastion_host_2= {
    Bastion_Host_name = "BASTION_HOST_2",
    subnet_id   = ""
  }
  }