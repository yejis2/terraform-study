resource "aws_subnet" "pub_subnet" {
  count             = length(local.pub_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.pub_cidr, count.index)
  availability_zone = ((count.index) % 2) == 0 ? local.zone_id.names[0] : local.zone_id.names[2]

  tags = {
    Name = "${local.project_name}-snet-${local.env}-pub-${((count.index) % 2) == 0 ? "a" : "c"}-apne2"
  }
}

