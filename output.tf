# Output for the Public IP of the Bastion Host
output "bastion_host_public_ip" {
  description = "The public IP of the Bastion Host"
  value       = aws_instance.bastion_host.public_ip
}

# Output for SSH Access Command
output "ssh_access_command" {
  description = "SSH command to access the Bastion Host"
  value       = "ssh -i ${aws_key_pair.utc_key.key_name}.pem ec2-user@${aws_instance.bastion_host.public_ip}"
}

# Output for the Bastion Host's Public DNS
output "bastion_host_public_dns" {
  description = "The public DNS of the Bastion Host"
  value       = aws_instance.bastion_host.public_dns
}

# Output for Instance ID of the Bastion Host
output "bastion_host_instance_id" {
  description = "The Instance ID of the Bastion Host"
  value       = aws_instance.bastion_host.id
}

# Output for Load Balancer DNS
output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = aws_lb.utc_alb.dns_name
}
