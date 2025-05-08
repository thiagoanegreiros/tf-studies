variable "ingress_rules" {
  type = map(number)
  default = {
    http: 80,
    https: 443
  }
  description = "A map of string values"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "example" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "aws_vpc.main.id"

  tags = {
    Name = "allow_tls"
  }

  dynamic "egress" {
    for_each = var.ingress_rules
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = egress.key
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

variable "vpcs" {
  type = map(object({
    cidr_block = string
  }))
  default = {
    vpc_01: {
      cidr_block: "10.0.0.0/16"
    },
    vpc_02: {
      cidr_block: "10.1.0.0/16"
    }

  }
}

resource "aws_vpc" "example" {
  # One VPC for each element of var.vpcs
  for_each = var.vpcs

  # each.value here is a value from var.vpcs
  cidr_block = each.value.cidr_block
}

resource "aws_internet_gateway" "example" {
  # One Internet Gateway per VPC
  for_each = aws_vpc.example

  # each.value here is a full aws_vpc object
  vpc_id = each.value.id
}

output "vpc_ids" {
  value = {
    for k, v in aws_vpc.example : k => v.id
  }

  # The VPCs aren't fully functional until their
  # internet gateways are running.
  depends_on = [aws_internet_gateway.example]
}
