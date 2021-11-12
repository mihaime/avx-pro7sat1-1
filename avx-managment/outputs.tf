output "controller_private_ip" {
  value = module.aviatrix-controller-build.controller_private_ip
}

output "controller_public_ip" {
  value = module.aviatrix-controller-build.controller_public_ip
}

output "copilot_public_ip" {
  value = module.aviatrix-controller-build.copilot_public_ip
}
