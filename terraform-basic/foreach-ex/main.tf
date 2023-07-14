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

# variable "vm_num" {
#   type = list(string)
#   default = ["1", "2", "3"]
# }

# variable "port_num"{
#   type = list(string)
#   default = ["7070", "8080", "9090"]
# }

# locals {
#   vm_num = toset(var.vm_num)
# }

# locals {
#   custom_data_args = {
#     vm_num            = var.vm_num
#     port_num          = var.port_num
#   }
# }

resource "aws_instance" "example" {
  for_each = {
    vm1 = {
        listen_port = "7070",
        instance_tag_num = "1"
    }

    vm2 = {
        listen_port = "8080",
        instance_tag_num = "2"
    }

    vm3 = {
        listen_port = "9090",
        instance_tag_num = "3"
    }
  }

  ami                    = "ami-0c9c942bd7bf113a2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "mykeypair"
  # user_data              = base64encode(templatefile("${path.module}/install_apache2.tpl", local.custom_data_args))
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<html><body>Yeji - ${each.value.instance_tag_num}</body></html>" > /var/www/html/index.html
              sudo sed -i 's/Listen 80/Listen ${each.value.listen_port}/g' /etc/apache2/ports.conf 
              sudo systemctl restart apache2
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "Single-WebSrv-${each.value.instance_tag_num}"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 7070
    to_port     = 7070
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
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

# output "public_ip" {
#   value       = aws_instance.example[each.key].public_ip
#   description = "The public IP of the Instance"
# }

output "public_ip" {
  value = {
    for v, instance in aws_instance.example : v => instance.public_ip
  }
}