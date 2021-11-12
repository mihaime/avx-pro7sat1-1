
##########################################################################

resource "tls_private_key" "avx_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "avx_key" {
  key_name = "avx-controller"
  public_key = tls_private_key.avx_key.public_key_openssh

}




########################################################################
# IAM Role 

module "aviatrix-iam-roles" {
  source = "./mgmt-modules/aviatrix-controller-iam-roles"
}

########################################################################
# Controller EC2 instance + new VPC

module "aviatrix-controller-build" {
  source  = "./mgmt-modules/aviatrix-controller-build"
  keypair = aws_key_pair.avx_key.key_name
  ec2role = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  cidr = "10.41.245.0/27"
  region = var.region
}
