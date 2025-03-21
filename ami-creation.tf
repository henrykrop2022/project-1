
# Data source to fetch the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# # Resource to launch an instance from the Amazon Linux 2 AMI
# resource "aws_instance" "app_server_template" {
#   ami           = data.aws_ami.amazon_linux_2.id
#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.utc_key.key_name
#   subnet_id     = aws_subnet.public_subnet_1a.id
#   security_groups = [aws_security_group.app_server_sg.id]
#   iam_instance_profile = aws_iam_instance_profile.ec2_s3_access_instance_profile.name

#   tags = {
#     Name = "app-server-template"
#     env  = "dev"
#     team = "config management"
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd.x86_64 aws-cli
#               systemctl start httpd.service
#               systemctl enable httpd.service
#               echo "Hello World from $(hostname -f)" > /var/www/html/index.html
#               bash /path/to/cron_job.sh
#               EOF
# }

# # Resource to create an AMI from the launched instance
# resource "aws_ami_from_instance" "utcappserver" {
#   name               = "utcappserver-${formatdate("YYYY-MM-DD_HH-mm-ss", timestamp())}"
#   source_instance_id = aws_instance.app_server_template.id
#   description        = "AMI for app server"
#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "utcappserver1"
#     env  = "dev"
#     team = "config management"
#   }
# }
