variable "instance_type"{
    type = string
    default = "t2.micro"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env"{
  description = "environment where the instance is used for"
  default = "dev"
}

variable "init_script"{
    description = "default location of the init script"
    type = string
}