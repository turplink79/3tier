#Subnet: Public & Private Subnet

#######################################
#Public Subnet
###########################################


resource "aws_subnet" "public_turplink_subnet" {
  count             = var.quantity
  vpc_id            = aws_vpc.turplinkVpc.id
  cidr_block        = var.Public_cidr_block[count.index]
  availability_zone = var.availability_zone[count.index]

tags = {
    Name = "Public_turplinkgroup"
  }
}



# ################################################
# #Private Subnet
# ###############################################
# resource "aws_subnet" "Private_turplink_subnet" {
#   #count             = var.quantity
#   vpc_id            = aws_vpc.turplinkVpc.id
#   cidr_block        = var.Private_cidr_block
#   availability_zone = var.availability_zone

# tags = {
#     Name = "Private_turplinkgroup"
#   }
# }
