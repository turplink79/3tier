# Create Application Load Balancer
resource "aws_lb" "public_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public_turplink_subnet : subnet.id]
  security_groups    = [aws_security_group.public_turplink_sg.id]
}

# Create ALB Listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2_target_group.arn
  }
}
# Create Target Group for EC2 instances
resource "aws_lb_target_group" "ec2_target_group" {
  name     = "ec2-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.turplinkVpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

# Register EC2 instances with the Target Group
resource "aws_lb_target_group_attachment" "ec2_target_attachment" {
  count             = var.quantity
  target_group_arn = aws_lb_target_group.ec2_target_group.arn
  target_id        = aws_instance.turplinkgroups_EC2[count.index].id
  port             = 80
}