terraform {
  backend "azurerm" {
    resource_group_name  = "my-tfstate-rg"
    storage_account_name = "mytfstatestorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}