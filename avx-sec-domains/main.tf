module "az-security-domain_shared" {
  source  = "./avx-security-domain"
  domain_name = "shared"
}


module "az-security-domain_red" {
  source  = "./avx-security-domain"
  domain_name = "red"
  connected_to = "${module.az-security-domain_onprem.security_domain.domain_name}"
}
