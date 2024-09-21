terraform {
  backend "azurerm" {
    resource_group_name  = "myrg"
    storage_account_name = "rigastorage"
    container_name       = "rigacontainer"
    key                  = "terraform/riga.tfstate"
  }
}