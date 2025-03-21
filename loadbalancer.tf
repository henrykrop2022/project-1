resource "aws_lb" "utc_alb" {
  name               = "utc-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id,
    aws_subnet.public_subnet_1c.id
  ]

  tags = {
    Name = "utc-alb"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.utc_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.utc_target_group.arn
  }
}