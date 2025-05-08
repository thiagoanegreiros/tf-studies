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
