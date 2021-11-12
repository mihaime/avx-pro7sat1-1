terraform {

backend "s3" {
    bucket = "avx-controller"
    region = "eu-central-1"
    
    key    = "controller.tfstate"
    dynamodb_table = "avx-controller"
  }
}
