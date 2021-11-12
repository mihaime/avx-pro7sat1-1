resource "aws_iam_role_policy" "aviatrix-bootstrap-vm-s3" {
  name = "avx-bootstrap_vm_policy"
  role = aws_iam_role.bootstrap-vm-s3-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::*"
           ]
        }
    ]
}
 EOF
}

resource "aws_iam_role" "bootstrap-vm-s3-role" {
  name = "avx-bootstrap-vm-s3-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "bootstrap-vm-s3-role" {
  name = "avx-bootstrap-vm-s3-role"
  role = aws_iam_role.bootstrap-vm-s3-role.name
}

resource "aws_s3_bucket" "avtx-panvm-bootstrap-az1" {
  bucket_prefix = "avtx-panvm-bootstrap-az1"
  acl    = "private"

  tags = {
    Name = "PAN VM Bootstrap"
  }
}

resource "aws_s3_bucket" "avtx-panvm-bootstrap-az2" {
  bucket_prefix = "avtx-panvm-bootstrap-az2"
  acl    = "private"

  tags = {
    Name = "PAN VM Bootstrap"
  }
}

/*
data "template_file" "init_cfg" {
  template = "${file("init-cfg.tmpl")}"

  vars {
    vm_auth_key = var.vm_auth_key
    panorama_ip = var.panorama_ip
    template_stack_name = var.temp_stack
    device_group_name = var.device_group
  }
}
*/

resource "aws_s3_bucket_object" "panvm_content" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
  acl    = "private"
  key    = "content/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "panvm_license" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
  acl    = "private"
  key    = "license/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "panvm_software" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
  acl    = "private"
  key    = "software/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "cfg_upload" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
  key    = "config/init-cfg.txt"
  source = "./aws-pan-bootstrap/init-cfg.txt"
  etag   = filemd5("./aws-pan-bootstrap/init-cfg.txt")
}

resource "aws_s3_bucket_object" "bootstrap_upload" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
  key    = "config/bootstrap.xml"
  source = "./aws-pan-bootstrap/bootstrap.xml"
  etag   = filemd5("./aws-pan-bootstrap/bootstrap.xml")
}


######

resource "aws_s3_bucket_object" "panvm_content2" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
  acl    = "private"
  key    = "content/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "panvm_license2" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
  acl    = "private"
  key    = "license/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "panvm_software2" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
  acl    = "private"
  key    = "software/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "cfg_upload2" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
  key    = "config/init-cfg.txt"
  source = "./aws-pan-bootstrap/init-cfg.txt"
  etag   = filemd5("./aws-pan-bootstrap/init-cfg.txt")
}

resource "aws_s3_bucket_object" "bootstrap_upload2" {
  bucket = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
  key    = "config/bootstrap.xml"
  source = "./aws-pan-bootstrap/bootstrap.xml"
  etag   = filemd5("./aws-pan-bootstrap/bootstrap.xml")
}

#resource "aws_key_pair" "comp_generated_key" {
#  key_name   = "${var.key_name}_${var.region}"
#  public_key = var.public_key
#}
