module "web-app-dev"{
    source = "../module/my-web-app"
    region = "us-east-1"
    init_script = "../scripts/user_data.sh"
    env = "dev"
}