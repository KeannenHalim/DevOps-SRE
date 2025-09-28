output "public_web_ip"{
    description = "public ip address of the EC 2 instance for web"
    value = aws_instance.web.public_ip
}