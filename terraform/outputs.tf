output "public_ip" {
  description = "Public IP of the Odoo lab host."
  value       = aws_instance.odoo.public_ip
}

output "instance_id" {
  description = "EC2 instance ID (use with SSM Session Manager)."
  value       = aws_instance.odoo.id
}

output "ssh_tunnel_command" {
  description = "Open Odoo at http://localhost:8069 after running this."
  value       = "ssh -i <your-private-key> -L 8069:localhost:8069 ubuntu@${aws_instance.odoo.public_ip}"
}
