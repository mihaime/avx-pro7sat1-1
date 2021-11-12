terraform {
  backend "azurerm" {
    storage_account_name = "avxtransitstate"
    container_name       = "avxtransitstate"
    key                  = "secdomain.terraform.tfstate"
  }
}
