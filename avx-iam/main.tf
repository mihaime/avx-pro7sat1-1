##########################################
# Create IAM role on remote AWS Account

module "aviatrix-iam-roles" {
  source = "./aviatrix-controller-iam-roles"
  external-controller-account-id = "xxx"  #  AWS Account ID where Controller is deployed
}

resource "time_sleep" "iam_resource_propagation" {
  create_duration = "15s"

  triggers = {
    app_arn = module.aviatrix-iam-roles.aviatrix-role-app-arn
    ec2_arn  = module.aviatrix-iam-roles.aviatrix-role-ec2-arn
  }
}

#################################
# Create Account on Controller

resource "aviatrix_account" "pro7sat_iam_account_1" {
  account_name       = "aws-pro7-some-account_1"
  cloud_type         = 1
  aws_account_number = module.aviatrix-iam-roles.aws-account
  aws_iam            = true
  aws_role_app       = time_sleep.iam_resource_propagation.triggers["app_arn"]
  aws_role_ec2       = time_sleep.iam_resource_propagation.triggers["ec2_arn"]
}

# resource "aviatrix_account" "pro7sat_iam_account_2" {
#   account_name       = "aws-pro7-some-account_2"
#   cloud_type         = 1
#   aws_account_number = module.aviatrix-iam-roles.aws-account
#   aws_iam            = true
#   aws_role_app       = time_sleep.iam_resource_propagation.triggers["app_arn"]
#   aws_role_ec2       = time_sleep.iam_resource_propagation.triggers["ec2_arn"]
# }
