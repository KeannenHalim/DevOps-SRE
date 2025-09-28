resource "tls_private_key" "rsa_key"{
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_sensitive_file" "private_key" {
  filename = pathexpand("~/.ssh/${var.env}-${var.region}-web-key.pem")
  content  = tls_private_key.rsa_key.private_key_pem
  file_permission = "0600"
}