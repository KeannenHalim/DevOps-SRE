output "public_web_ip" {
  description = "Public IP address of the EC2 instance for web"
  value       = module.web-app-dev.public_web_ip
}