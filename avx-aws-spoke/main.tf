############### Test Spoke

module "az-department1-west-eu-unit1" {
  
  
 source  = "./avx-aws-spoke"


region                = "eu-central-1"

account               = "pts-aws-noc"
vpc_cidr             = "10.66.0.0/16"

gw_name              = "test-spoke"
vpc_name             = "test-vpc"

ha_gw                  = false

transit_gw           = "pts-avx-int-tgw"
security_domain      = "red"
}
