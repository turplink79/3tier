######################################
#Variable - VPC
################################

#VPC
variable "vpc_cidr_block" {
description = "cidr block for the VPC"
 type         = string
 default      = "10.0.0.0/16"
 
 }
##############################################
# Subnet Variable
##############################################

variable "quantity"{
    description = "number of resource"
    type = number
    default = 2
}
variable "Public_cidr_block" {
   description = "cidr block for subnet"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# variable "Private_cidr_block"{
#     description = "cidr block for subnet"
#     type        = string
#     default     =  "10.0.11.0/24"

# }

# variable "database_cidr_block"{
#     description = "cidr block for subnet"
#     type        = string)
#     default     =  ["10.0.21.0/24", "10.0.22.0/24"]

# }

variable "availability_zone"{
    description = "availability zones"
    type        = list(string)
    default     =  ["us-east-1a", "us-east-1b"]

}
variable "eip_name" {
  description = "The name of the Elastic IP"
  default     = "turplink_eip"
}

variable "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  default     = "turplink_nat_gateway"
}