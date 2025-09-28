resource "aws_instance" "web"{
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = element(data.aws_subnets.default.ids,0)
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = aws_key_pair.key_pair.key_name
    user_data = file(var.init_script)
    tags = {
        Name = "web"
    }
}

resource "aws_key_pair" "key_pair"{
    key_name = "web-key"
    public_key = tls_private_key.rsa_key.public_key_openssh 
}

data "aws_ami" "amazon_linux"{
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}