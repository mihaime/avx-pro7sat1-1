module "az-spoke-west-europe-prod-spoke-2" {
  source  = "./avx-custom-spoke"

  cidr             = "10.255.255.0/24"  # Additional CIDR
  vpc_id  = "vpc-0aa31244c66335613"  # can be name, I think.
  igw_exists = true # default true

  gw_name  = "customer_gw"   # ?
  region                = "eu-central-1" # ?
  account               = "pts-aws-noc"  # ?
}


module "az-spoke-west-europe-prod-spoke-1" {
  source  = "./avx-custom-spoke"

  cidr             = "10.255.250.0/24"  # Additional CIDR
  vpc_id  = "vpc-0cd9ca04ff02be1f3"
  igw_exists = false # default true

  gw_name = "another-custom-gw"
  region                = "us-east-1"
  account               = "pts-aws-noc"
  providers = {aws = aws.east1}
}
