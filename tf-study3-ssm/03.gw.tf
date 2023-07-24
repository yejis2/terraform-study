resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project_name}-igw-${local.env}-vpc-apne2"
  }
}

resource "aws_eip" "natgw_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw_az1" {
  allocation_id = aws_eip.natgw_ip.id
  subnet_id     = aws_subnet.pub_subnet[0].id

  tags = {
    Name = "${local.project_name}-ntgw-${local.env}-pub-apne2a"
  }

  depends_on = [aws_internet_gateway.igw]
}