output controller_private_ip {
  value       = aws_instance.aviatrixcontroller.private_ip
  description = "List of private IPs for aviatrix conroller"
}

output controller_public_ip {
  value       = aws_eip.controller_eip.public_ip
  description = "List of public IPs for aviatrix conroller"
}

output copilot_public_ip {
  value       = aws_eip.copilot_eip.public_ip
  description = "List of public IPs for aviatrix conroller"
}

output vpc_id {
  value       = aws_vpc.avtx_ctrl_vpc.id
  description = "VPC where Aviatrix controller was built"
}

output subnet_id {
  value       = aws_subnet.avtx_ctrl_subnet.id
  description = "Subnet where Aviatrix controller was built"
}

output security_group_id {
  value       = aws_security_group.AviatrixSecurityGroup.id
  description = "Security group id used by Aviatrix controller"
}

output name_prefix {
  value = var.name_prefix
}
