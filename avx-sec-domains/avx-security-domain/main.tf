locals {
  create_policy = length(compact(tolist([var.connected_to]))) > 0 # return True when connected_to is not empty
}

# Create an Aviatrix Segmentation Security Domain
resource "aviatrix_segmentation_security_domain" "segmentation_security_domain" {
  domain_name = var.domain_name
}

# Create an Aviatrix Segmentation Security Domain
resource "aviatrix_segmentation_security_domain_connection_policy" "segmentation_security_domain_connection_policy" {
  for_each = local.create_policy ? toset(split(",", (var.connected_to))) : toset([])
  domain_name_1 = aviatrix_segmentation_security_domain.segmentation_security_domain.domain_name
  domain_name_2 = trimspace(each.value)
}
