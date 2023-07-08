terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c9c942bd7bf113a2"
  instance_type          = "t3.micro"
  subnet_id             = aws_subnet.pub_subnet.id
  vpc_security_group_ids = [aws_security_group.instance.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<html><body>Yeji</body></html>" > /var/www/html/index.html
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "Single-WebSrv 2"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name
  vpc_id      = aws_vpc.testvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}

# Create a VPC
resource "aws_vpc" "testvpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.testvpc.id
  cidr_block = "192.168.1.0/24"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.testvpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.testvpc.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "rtasso" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.rt.id
}