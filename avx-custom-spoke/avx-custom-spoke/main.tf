####


data "aws_internet_gateway" "default" {
  count = var.igw_exists ? 1 : 0
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

#### Additional VPC Address Space

resource "aws_vpc_ipv4_cidr_block_association" "default" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
}

###### Public Subnet for Spoke GW

resource "aws_subnet" "default" {
  vpc_id     = var.vpc_id
  cidr_block = aws_vpc_ipv4_cidr_block_association.default.cidr_block

  tags = {
    Name = "Aviatrix-GW-Subnet",
    Name = "Aviatrix-Do-Not-Delete"
  }
}

# AWS iGW

resource "aws_internet_gateway" "default" {
  count = var.igw_exists ? 0 : 1
  vpc_id = var.vpc_id
}


# Public Route Table

resource "aws_route_table" "default" {
  vpc_id = var.vpc_id

  route = [
  {
    cidr_block                = "0.0.0.0/0"
    egress_only_gateway_id    = ""
    gateway_id                = var.igw_exists ? data.aws_internet_gateway.default[0].id : aws_internet_gateway.default[0].id
    instance_id               = ""
    ipv6_cidr_block           = ""
    nat_gateway_id            = ""
    network_interface_id      = ""
    transit_gateway_id        = ""
    vpc_peering_connection_id = ""
    carrier_gateway_id = ""
    destination_prefix_list_id = ""
    ipv6_cidr_block = ""
    local_gateway_id = ""
    vpc_endpoint_id = ""
  },
 ]
}

# RT to Subnet association

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.default.id
  route_table_id = aws_route_table.default.id
}


############ Spoke GW

resource "aviatrix_spoke_gateway" "default" {
  cloud_type                        = 1
  account_name                      = var.account
  gw_name                           = var.gw_name
  vpc_id                            = var.vpc_id
  vpc_reg                           = var.region
  gw_size                           = var.instance_size
  # ha_gw_size                        = var.ha_gw ? var.instance_size : null
  subnet                            = aws_subnet.default.cidr_block
  # ha_subnet                         = var.ha_gw ? azurerm_subnet.avx-gateway-subnet-hagw.address_prefixes[0] : null
  insane_mode                       = var.insane_mode # ??
  enable_active_mesh                = var.active_mesh
  manage_transit_gateway_attachment = false
  single_az_ha                      = var.single_az_ha 
  single_ip_snat                    = var.single_ip_snat
  customized_spoke_vpc_routes       = var.customized_spoke_vpc_routes
  filtered_spoke_vpc_routes         = var.filtered_spoke_vpc_routes
  included_advertised_spoke_routes  = var.included_advertised_spoke_routes
  # zone                     = var.ha_gw ? (var.single_az_ha ? null : "az-1") : null
  # ha_zone                  = var.ha_gw ? (var.single_az_ha ? null : "az-2") : null
  
  depends_on = [
    aws_route_table_association.default
  ]
}

#### Spoke Attachment to Transit

# resource "aviatrix_spoke_transit_attachment" "avx-spoke-gw-att" {
#   spoke_gw_name   = aviatrix_spoke_gateway.avx-spoke-gw.gw_name
#   transit_gw_name = var.transit_gw
#   depends_on = [azurerm_subnet_route_table_association.subnet-vm1-to-rt1, azurerm_subnet_route_table_association.subnet-vm2-to-rt2] # Create Spoke attachment AFTER route table associations
#
# }
#
#
# ### Security Domain Association
#
# resource "aviatrix_segmentation_security_domain_association" "spoke-security-domain" {
#   count =  var.security_domain == "" ? 0 : 1
#   transit_gateway_name = var.transit_gw
#   security_domain_name = var.security_domain
#   attachment_name      = aviatrix_spoke_gateway.avx-spoke-gw.gw_name
#   depends_on           = [aviatrix_spoke_transit_attachment.avx-spoke-gw-att] # create  security association after spoke attachment
# }
