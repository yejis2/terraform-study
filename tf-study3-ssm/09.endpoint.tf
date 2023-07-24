resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.vpc.id
  service_name = "com.amazonaws.${local.seoul_region}.ssm"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true

  tags = { Name = "${local.project_name}-ep-${local.env}-ssm" }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.vpc.id
  service_name = "com.amazonaws.${local.seoul_region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true

  tags = { Name = "${local.project_name}-ep-${local.env}-ssmmessages" }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.vpc.id
  service_name = "com.amazonaws.${local.seoul_region}.ec2messages"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.endpoint_sg.id]
  private_dns_enabled = true

  tags = { Name = "${local.project_name}-ep-${local.env}-ec2messages" }
}

