output "bootstrap_s3_role" {
  value = aws_iam_role.bootstrap-vm-s3-role.id
}

output "bootstrap_bucket_az1" {
  value = aws_s3_bucket.avtx-panvm-bootstrap-az1.id
}

output "bootstrap_bucket_az2" {
  value = aws_s3_bucket.avtx-panvm-bootstrap-az2.id
}
