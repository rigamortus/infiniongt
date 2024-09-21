locals {
  env = yamldecode(file("env.yaml"))
}

resource "azurerm_virtual_network" "myvnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "North Europe"
  resource_group_name = "myrg"
}

resource "azurerm_subnet" "my_subnet" {
  name                 = "default"
  resource_group_name  = "myrg"
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "appgw" {
  name                 = "appgw"
  resource_group_name  = "myrg"
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["172.16.0.0/24"]
}