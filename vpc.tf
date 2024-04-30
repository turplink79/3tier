

###############################
#VPC
############################
resource "aws_vpc" "turplinkVpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "turplinkgroup"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.turplinkVpc.id
}

# Attach Internet Gateway to public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.turplinkVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count             = var.quantity
  subnet_id      = aws_subnet.public_turplink_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
