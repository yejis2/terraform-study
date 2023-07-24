####### web instance - apache ########
resource "aws_instance" "web" {
  ami                         = data.aws_ami.latest_ubuntu2204.id
  instance_type               = local.instance_type[0]
  subnet_id                   = aws_subnet.pub_subnet[0].id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = local.key_pair_name
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.iam_inst_profile.name

  root_block_device {
    volume_size           = "8"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  tags = { Name = "${local.project_name}-ec2-${local.env}-tf-apne2" }
}

resource "null_resource" "for_remote-exec" {  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("${path.module}/mykeypair.pem")
    # host     = self.public_ip
    host = aws_instance.web.public_ip
  }

  provisioner "file" {
    source      = "install-apache.sh"
    destination = "install-apache.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x install-apache.sh",
      "./install-apache.sh"
    ]
  }
}

output "public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP of the Instance"
}