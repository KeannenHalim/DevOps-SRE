module "web-app-prod"{
    source = "../module/my-web-app"
    region = "us-east-1"
    init_script = "../scripts/user_data.sh"
    env = "prod"
}