variable "domain_name" {
  description = "Name of the Security Domain 1"
  type        = string
}

variable "connected_to" {
  description = " Name of the Security Domains to connect to Domain 1"
  type        = string
  default = ""
}

variable "create_policy" {
  default = false
}
