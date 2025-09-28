#!/bin/bash
sudo amazon-linux-extras install nginx1
echo "Hello, OpenTofu!" | sudo tee /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx