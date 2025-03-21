# resource "aws_sns_topic" "utc_auto_scaling" {
#   name = "utc-auto-scaling"

#   tags = {
#     Name = "utc-auto-scaling"
#     env  = "dev"
#     team = "config management"
#   }
# }

# resource "aws_sns_topic_subscription" "team_subscription" {
#   topic_arn = aws_sns_topic.utc_auto_scaling.arn
#   protocol  = "email"
#   endpoint  = "team@example.com" # Replace with the actual team email
# }

# resource "aws_autoscaling_notification" "asg_notifications" {
# #   group_names = [aws_autoscaling_group.app_asg.name]
#   notifications = [
#     "autoscaling:EC2_INSTANCE_LAUNCH",
#     "autoscaling:EC2_INSTANCE_TERMINATE",
#     "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
#     "autoscaling:EC2_INSTANCE_TERMINATE_ERROR"
#   ]
#   topic_arn = aws_sns_topic.utc_auto_scaling.arn
# }