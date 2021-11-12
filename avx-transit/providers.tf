provider "aviatrix" {
  username      = "admin"
  password      = var.ctrl_password
  controller_ip = var.ctrl_ip
}


provider "aws" {
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
