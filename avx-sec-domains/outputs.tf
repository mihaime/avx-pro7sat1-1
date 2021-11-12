output "security_domain_shared" {
  description = "The Aviatrix security domain"
  value       = module.az-security-domain_shared.security_domain.domain_name
}

output "security_domain_red" {
  description = "The Aviatrix security domain"
  value       = module.az-security-domain_red.security_domain.domain_name
}


output "az-security-domain_onprem" {
  description = "The Aviatrix security domain"
  value       = module.az-security-domain_onprem.security_domain.domain_name
}
