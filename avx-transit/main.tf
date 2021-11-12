####

module "aws-vmseries-bootstrap" {
  source = "./aws-pan-bootstrap"
}


### Transit Network "West Europe"

module "aws-central-eu-dep-b" {
  source  = "./avx-aws-transit-firenet"
  region                 = "eu-central-1"
  account                = "pts-aws-noc"

  cidr                   = "10.41.240.0/23"

  gw_name                = "pts-avx-int-tgw"
  vpc_name              = "pts-avx-int-tgw-vpc"

  local_as_number        = "65509"

  # ha_gw                  = false # default is true
  # egress_enabled         = true  # default is false
  firewall_name          = "pts-avx-int-tgw-fw"
  firewall_image         = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
  firewall_image_version = "9.1.9"


  bootstrap_bucket_name_1 = module.aws-vmseries-bootstrap.bootstrap_bucket_az1
  iam_role_1             =   module.aws-vmseries-bootstrap.bootstrap_s3_role

  bootstrap_bucket_name_2 = module.aws-vmseries-bootstrap.bootstrap_bucket_az2
  iam_role_2             =   module.aws-vmseries-bootstrap.bootstrap_s3_role
}


#### Empty Comment!

# ####
resource "aviatrix_transit_external_device_conn" "transit_external_device_conn1" {
  vpc_id                    = module.aws-central-eu-dep-b.vpc.vpc_id
  connection_name           = "avx-tgw-gre-to-rtr3-extern"
  gw_name                   = module.aws-central-eu-dep-b.transit_gateway.gw_name
  remote_gateway_ip         = "172.23.251.173"
  connection_type           = "bgp"
  direct_connect            = true
  bgp_local_as_num          = module.aws-central-eu-dep-b.transit_gateway.local_as_number
  bgp_remote_as_num         = "65000"
  tunnel_protocol           = "GRE"
  ha_enabled                = false
  local_tunnel_cidr         = "169.254.100.1/30,169.254.101.1/30"
  remote_tunnel_cidr        = "169.254.100.2/30,169.254.101.2/30"
  custom_algorithms         = false
  enable_event_triggered_ha = null
}



resource "aviatrix_transit_external_device_conn" "transit_external_device_conn2" {
  vpc_id                    = module.aws-central-eu-dep-b.vpc.vpc_id
  connection_name           = "avx-tgw-gre-to-rtr4-extern"
  gw_name                   = module.aws-central-eu-dep-b.transit_gateway.gw_name
  remote_gateway_ip         = "172.23.251.174"
  connection_type           = "bgp"
  direct_connect            = true
  bgp_local_as_num          = module.aws-central-eu-dep-b.transit_gateway.local_as_number
  bgp_remote_as_num         = "65000"
  tunnel_protocol           = "GRE"
  ha_enabled                = false
  local_tunnel_cidr         = "169.254.200.1/30,169.254.201.1/30"
  remote_tunnel_cidr        = "169.254.200.2/30,169.254.201.2/30"
  custom_algorithms         = false
  enable_event_triggered_ha = null
}


# resource "aviatrix_transit_external_device_conn" "transit_external_device_conn_1" {
#     vpc_id = "vpc-0b1a314e028ca31c4"
#     connection_name = "to-pan-fws"
#     gw_name = "pts-avx-int-tgw"
#     remote_gateway_ip = "172.23.251.173"
#     connection_type = "bgp"
#     direct_connect = true
#     bgp_local_as_num = "65509"
#     bgp_remote_as_num = "65000"
#     tunnel_protocol = "GRE"
#     ha_enabled = true
#     local_tunnel_cidr = "169.254.100.1/30,169.254.101.1/30"
#     remote_tunnel_cidr = "169.254.100.2/30,169.254.101.2/30"
#     backup_local_tunnel_cidr = "169.254.200.1/30,169.254.201.1/30"
#     backup_remote_tunnel_cidr = "169.254.200.2/30,169.254.201.2/30"
#     custom_algorithms = false
#     backup_bgp_remote_as_num = "65000"
#     backup_remote_gateway_ip = "172.23.251.174"
#     backup_direct_connect = true
#     enable_edge_segmentation = false
# }
