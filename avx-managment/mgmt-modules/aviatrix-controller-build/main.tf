#### Controller EIP and iface
resource "aws_eip" "controller_eip" {
  vpc   = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.aviatrixcontroller.id
  allocation_id = aws_eip.controller_eip.id
}

resource "aws_network_interface" "eni-controller" {
  subnet_id       = aws_subnet.avtx_ctrl_subnet.id
  security_groups = [aws_security_group.AviatrixSecurityGroup.id]
  tags            = {
    Name      = format("%s%s", local.name_prefix, "Aviatrix Controller interface")
    Createdby = "Terraform+Aviatrix"
  }
}

#### Copilot EIP and iface

resource "aws_eip" "copilot_eip" {
  vpc   = true
}

resource "aws_eip_association" "eip_assoc_cplt" {
  instance_id   = aws_instance.aviatrixcopilot.id
  allocation_id = aws_eip.copilot_eip.id
}

resource "aws_network_interface" "eni-copilot" {
  subnet_id       = aws_subnet.avtx_ctrl_subnet.id
  security_groups = [aws_security_group.AviatrixSecurityGroupCPLT.id]
  tags            = {
    Name      = format("%s%s", local.name_prefix, "Aviatrix Copilot interface")
    Createdby = "Terraform+Aviatrix"
  }
}



#### EC2 Controller 

resource "aws_instance" "aviatrixcontroller" {
  ami                     = local.ami_id
  instance_type           = var.instance_type
  key_name                = var.keypair
  iam_instance_profile    = var.ec2role
  disable_api_termination = var.termination_protection

  network_interface {
    network_interface_id = aws_network_interface.eni-controller.id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  tags = {
    Name      = "AviatrixController"
    Createdby = "Terraform+Aviatrix"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

#### EC2 Copilot 
resource "aws_instance" "aviatrixcopilot" {

  ami                     = "ami-0863c862a9cefd8ae"  # This is AMI in eu-central-1
  instance_type           = "t3.2xlarge"             # 32GB RAM minimum
  key_name                = var.keypair

  network_interface {
    network_interface_id = aws_network_interface.eni-copilot.id
    device_index         = 0
  }
  tags = {
    Name      = "AviatrixCopilot"
    Createdby = "Terraform+Aviatrix"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}