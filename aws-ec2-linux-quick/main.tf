terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ec2server_security_group" {
  name        = var.aws_security_group_name
  description = "EC2 server security group"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each          = toset(var.aws_ingress_cidrs)
  description       = "Allow ssh in"
  from_port         = 22
  ip_protocol       = "-1"
  security_group_id = aws_security_group.ec2server_security_group.id
  to_port           = 22
  cidr_ipv4         = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_out" {
  for_each          = toset(var.aws_ingress_cidrs)
  description       = "Allow all out"
  from_port         = 0
  ip_protocol       = "-1"
  security_group_id = aws_security_group.ec2server_security_group.id
  to_port           = 0
  cidr_ipv4         = each.value
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.aws_ssh_key_name
  public_key = file(var.aws_ssh_keyfile)
}

resource "aws_instance" "ec2server" {
  ami                         = var.aws_ami_id
  instance_type               = var.aws_instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2server_security_group.id]
  associate_public_ip_address = true
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2server.public_ip
}

