terraform{
    backend "s3"{
        bucket = "my-terraform-web-app-remote-state"
        key = "dev/web-app/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "my-terraform-web-app-remote-state-lock"
    }
}