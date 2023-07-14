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
  for_each = var.apache_setup
  ami                    = data.aws_ami.latest_amazon_linux_2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.apache_sg.id]
  key_name = "jh-testkey"

  user_data = base64encode(templatefile("${path.module}/setup_apache.tpl", merge({port_num = each.value.listen_port}, {my_name = each.value.my_name})))

  tags = { Name = "${var.name}-apache-instance-${each.value.instance_tag_num}" }
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


output "instance_public_ips" {
  value = {
    for v, instance in aws_instance.apache : v => instance.public_ip
  }
}

# 해당 코드에서는 for 구문을 사용하여 aws_instance.apache에 정의된 모든 인스턴스를 반복합니다. 
# aws_instance.apache는 aws_instance 리소스 블록에서 생성한 인스턴스들을 가리킵니다. 
# v는 반복 변수로 사용되며, instance는 각 인스턴스 객체를 나타냅니다.

# value 설정에서는 인스턴스의 반복 변수 v를 키(key)로, 해당 인스턴스의 public_ip 속성을 값(value)으로 하는 맵(Map)을 생성합니다.
# 이렇게 생성된 맵은 output으로 반환되어 테라폼 실행 후에 조회할 수 있습니다.

# 예를 들어, instance_public_ips를 조회하면 다음과 같은 형태로 인스턴스의 퍼블릭 IP 주소를 확인할 수 있습니다