provider "aws" {
  region = "ap-northeast-2"
}

###### ami data ######
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*amzn2-ami-hvm*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"]
}

###### ec2 ######
resource "aws_instance" "apache" {
  count                  = length(var.port_num)
  ami                    = data.aws_ami.latest_amazon_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  key_name = "jh-testkey"

  user_data = base64encode(templatefile("${path.module}/setup_apache.tpl", merge({port_num = var.port_num[count.index]}, {my_name = var.my_name[count.index]})))

  tags = { Name = "${var.name}-apache-instance-${count.index+1}" }
}

###### security group ######
resource "aws_security_group" "apache_sg" {
  name = "${var.name}-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

output "instance1_public_ip" {
  value = "curl ${aws_instance.apache[0].public_ip}:${var.port_num[0]}"
}
output "instance2_public_ip" {
  value = "curl ${aws_instance.apache[1].public_ip}:${var.port_num[1]}"
}
output "instance3_public_ip" {
  value = "curl ${aws_instance.apache[2].public_ip}:${var.port_num[2]}"
}