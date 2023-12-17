resource "aws_key_pair" "key" {
  key_name   = "${var.prefix}-key"
  public_key = file("~/.ssh/cloud_2024.pem.pub")
}

resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets_BS
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true # To ensure the instance gets a public IP

  tags = {
    Name = join("-", [var.prefix, each.key])
  }
}

resource "aws_route_table" "rt_public_BS" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "rta_public_BS" {
  for_each       = var.public_subnets_BS
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.rt_public_BS.id
}

resource "aws_instance" "Bastion_Host" {
  for_each      = var.Bastion_Host_ec2
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name

  subnet_id = aws_subnet.public_subnets_BS[each.key].id
  #vpc_security_group_ids = [module.security_groups.security_group_id["cloud_2023_sg"]] 
  vpc_security_group_ids = [module.security-groups.security_group_id["bastion_host_sg"]]
  #   user_data              = <<-EOF
  #                            #!/bin/bash
  #                            sudo yum update -y
  #                            sudo yum install -y httpd
  #                            sudo systemctl start httpd.service
  #                            sudo systemctl enable httpd.service
  #                            sudo echo "<h1> HELLO from ${upper(each.key)}_SERVER </h1>" > /var/www/html/index.html                  
  #                            EOF
  tags = {
    Name = join("_", [var.prefix, each.key])
  }
}

module "security-groups" {
  source          = "app.terraform.io/summercloud/security-groups/aws"
  version         = "3.0.0"
  vpc_id          = aws_vpc.vpc.id
  security_groups = var.security_groups
}