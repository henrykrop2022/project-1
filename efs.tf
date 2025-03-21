resource "aws_efs_file_system" "app_efs" {
  creation_token = "app_efs"
  tags = {
    Name = "app_efs"
    env  = "dev"
    team = "config management"
  }
}

resource "aws_efs_mount_target" "app_efs_1a" {
  file_system_id = aws_efs_file_system.app_efs.id
  subnet_id      = aws_subnet.private_subnet_1a.id
  security_groups = [aws_security_group.app_server_sg.id]
}

resource "aws_efs_mount_target" "app_efs_1b" {
  file_system_id = aws_efs_file_system.app_efs.id
  subnet_id      = aws_subnet.private_subnet_1b.id
  security_groups = [aws_security_group.app_server_sg.id]
}