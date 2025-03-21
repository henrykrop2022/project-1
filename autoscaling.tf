# resource "aws_launch_template" "app_launch_template" {
#   name = "app_launch_template"

#   image_id      = aws_ami_from_instance.utcappserver.id
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.utc_key.key_name

#   vpc_security_group_ids = [
#     aws_security_group.app_server_sg.id
#   ] 

#    network_interfaces {
#     associate_public_ip_address = true # Ensure instances get a public IP
#     security_groups             = [aws_security_group.app_server_sg.id]
#   }

#   user_data = base64encode(<<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd.x86_64 aws-cli
#               systemctl start httpd.service
#               systemctl enable httpd.service
#               echo "Hello World from $(hostname -f)" > /var/www/html/index.html
#               bash /path/to/cron_job.sh
#               EOF
#   )

#   tags = {
#     Name = "app_launch_template"
#     env  = "dev"
#     team = "config management"
#   }
# }

# resource "aws_autoscaling_group" "app_asg" {
#   desired_capacity     = 2
#   max_size             = 5
#   min_size             = 1
#   vpc_zone_identifier  = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
#   target_group_arns    = [aws_lb_target_group.utc_target_group.arn]
#   launch_template {
#     id      = aws_launch_template.app_launch_template.id
#     version = "$Latest"
#   }

#   tag {
#     key                 = "Name"
#     value               = "app_asg"
#     propagate_at_launch = true
#   }
# }

# resource "aws_autoscaling_policy" "scale_out_policy" {
#   name                   = "scale_out_policy"
#   autoscaling_group_name = aws_autoscaling_group.app_asg.name
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
# }

# resource "aws_autoscaling_policy" "scale_in_policy" {
#   name                   = "scale_in_policy"
#   autoscaling_group_name = aws_autoscaling_group.app_asg.name
#   scaling_adjustment     = -1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
# }

# resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
#   alarm_name          = "high_cpu_alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 2
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = 120
#   statistic           = "Average"
#   threshold           = 80
#   alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn]
#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.app_asg.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "low_cpu_alarm" {
#   alarm_name          = "low_cpu_alarm"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = 2
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = 120
#   statistic           = "Average"
#   threshold           = 30
#   alarm_actions       = [aws_autoscaling_policy.scale_in_policy.arn]
#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.app_asg.name
#   }
# }