############################################################################################################
# Create IAM roles on remote AWS Account. AWS Account where you would launch CloudFormation
provider "aws" {
  region     = "eu-central-1" # any region will work, IAM are global
  access_key = "xxx"  # remote AWS Account where you would launch CloudFormation
  secret_key = "xxx"  # remote AWS Account where you would launch CloudFormation
}


provider "aviatrix" {
  username     = "admin"
  password      = "xxx"
  controller_ip = "xxx"
  version       = "xxx"
}
