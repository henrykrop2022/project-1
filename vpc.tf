provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "utc_vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "utc-vpc"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_internet_gateway" "utc_igw" {
  vpc_id = aws_vpc.utc_vpc.id

  tags = {
    Name = "utc-igw"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "utc-public-1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "utc-public-1b"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1c"
  
  tags = {
    Name = "utc-public-1c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.4.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "utc-private-1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "utc-private-1b"
  }
}

resource "aws_subnet" "private_subnet_1a_extra" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.6.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Name = "utc-private-1a-extra"
  }
}

resource "aws_subnet" "private_subnet_1b_extra" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.7.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "utc-private-1b-extra"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.8.0/24"
  availability_zone = "us-east-1c"
  
  tags = {
    Name = "utc-private-1c"
  }
}

resource "aws_subnet" "private_subnet_1c_extra" {
  vpc_id            = aws_vpc.utc_vpc.id
  cidr_block        = "10.10.9.0/24"
  availability_zone = "us-east-1c"
  
  tags = {
    Name = "utc-private-1c-extra"
  }
}

resource "aws_nat_gateway" "nat_gateway_1a" {
  allocation_id = aws_eip.nat_eip_1a.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "utc-nat-1a"
  }
}

resource "aws_nat_gateway" "nat_gateway_1b" {
  allocation_id = aws_eip.nat_eip_1b.id
  subnet_id     = aws_subnet.public_subnet_1b.id

  tags = {
    Name = "utc-nat-1b"
  }
}

resource "aws_eip" "nat_eip_1a" {
  domain = "vpc"
}

resource "aws_eip" "nat_eip_1b" {
  domain = "vpc"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.utc_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.utc_igw.id
  }

  tags = {
    Name = "utc-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_1b_association" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_1c_association" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_1a" {
  vpc_id = aws_vpc.utc_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1a.id
  }

  tags = {
    Name = "utc-private-rt-1a"
  }
}

resource "aws_route_table" "private_route_table_1b" {
  vpc_id = aws_vpc.utc_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
  }

  tags = {
    Name = "utc-private-rt-1b"
  }
}

resource "aws_route_table" "private_route_table_1c" {
  vpc_id = aws_vpc.utc_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
  }

  tags = {
    Name = "utc-private-rt-1c"
  }
}

resource "aws_route_table_association" "private_subnet_1a_association" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route_table_1a.id
}

resource "aws_route_table_association" "private_subnet_1b_association" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_route_table_1b.id
}

resource "aws_route_table_association" "private_subnet_1a_extra_association" {
  subnet_id      = aws_subnet.private_subnet_1a_extra.id
  route_table_id = aws_route_table.private_route_table_1a.id
}

resource "aws_route_table_association" "private_subnet_1b_extra_association" {
  subnet_id      = aws_subnet.private_subnet_1b_extra.id
  route_table_id = aws_route_table.private_route_table_1b.id
}

resource "aws_route_table_association" "private_subnet_1c_association" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.private_route_table_1c.id
}

resource "aws_route_table_association" "private_subnet_1c_extra_association" {
  subnet_id      = aws_subnet.private_subnet_1c_extra.id
  route_table_id = aws_route_table.private_route_table_1c.id
}