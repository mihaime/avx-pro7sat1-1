terraform {

backend "s3" {
    bucket = "avx-transit-net"
    region = "eu-central-1"

    key    = "transit.tfstate"
    dynamodb_table = "avx-controller"
  }
}
