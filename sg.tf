################################
#Security Group
#################################

resource "aws_security_group" "public_turplink_sg" {
  #count       = var.quantity
  vpc_id      = aws_vpc.turplinkVpc.id
  name        = "public-turplink-sg"
  
  // Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow HTTP traffic from anywhere
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow HTTPS traffic from anywhere
  }
  
  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  // Allow all outbound traffic
  }
}
