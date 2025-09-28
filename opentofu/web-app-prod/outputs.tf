output "public_web_ip" {
  description = "Public IP address of the EC2 instance for web"
  value       = module.web-app-prod.public_web_ip
}