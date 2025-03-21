resource "aws_lb_target_group" "utc_target_group" {
  name        = "utc-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.utc_vpc.id
  target_type = "instance"

  health_check {
    path     = "/"
    protocol = "HTTP"
  }

  tags = {
    env  = "dev"
    team = "config management"
  }
}

resource "aws_lb_target_group_attachment" "app_server_1a_1" {
  target_group_arn = aws_lb_target_group.utc_target_group.arn
  target_id        = aws_instance.app_server_1a_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_1a_2" {
  target_group_arn = aws_lb_target_group.utc_target_group.arn
  target_id        = aws_instance.app_server_1a_2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_1b_1" {
  target_group_arn = aws_lb_target_group.utc_target_group.arn
  target_id        = aws_instance.app_server_1b_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_1b_2" {
  target_group_arn = aws_lb_target_group.utc_target_group.arn
  target_id        = aws_instance.app_server_1b_2.id
  port             = 80
}