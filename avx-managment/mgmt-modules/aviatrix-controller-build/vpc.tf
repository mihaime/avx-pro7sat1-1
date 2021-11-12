resource "aws_vpc" "avtx_ctrl_vpc" {
  cidr_block       = var.cidr

  tags = {
    Name = "avx-managment-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.avtx_ctrl_vpc.id
}

resource "aws_subnet" "avtx_ctrl_subnet" {
  availability_zone = "${var.region}a"
  vpc_id     = aws_vpc.avtx_ctrl_vpc.id
  cidr_block = local.subnet_zone_a

  tags = {
    Name = "avx-mgmt-zone-a"
  }
}

resource "aws_subnet" "avtx_ctrl_subnet-b" {
  availability_zone =  "${var.region}b"
  vpc_id     = aws_vpc.avtx_ctrl_vpc.id
  cidr_block = local.subnet_zone_b

  tags = {
    Name = "avx-mgmt-zone-b"
  }
}


resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.avtx_ctrl_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
