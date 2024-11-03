resource "azurerm_virtual_network" "vnet" {
  for_each            = { for x in var.config.vnets : x.name => x }
  address_space       = each.value.address_space
  location            = each.value.location
  name                = each.value.vnet_prefix != null ? "${each.value.vnet_prefix}-${each.value.name}" : each.value.name
  resource_group_name = each.value.resource_group_name
  tags                =  {
        for k, v in each.value.tags:
    k => k == "Name" ? "riga-${v}" : v
  }
  lifecycle {
    create_before_destroy = true
  }

  # dynamic "subnet" {
  #   for_each = each.value.subnet
  #   content {
  #     name = subnet.value.name
  #     address_prefixes = subnet.value.address_prefix

  #   }
  # }

}

output "vnet_id" {
  value = { for name, vnets in azurerm_virtual_network.vnet : name => vnets.id }
}

# output "subnet_id" {
#   value = { for name, subnets in azurerm_virtual_network.vnet.subnet : name => vnets.subnet.id }
# }

# locals {
#   subnet_ids = {
#     for vnet_name, vnet in azurerm_virtual_network.vnet : vnet_name => [
#       for s in vnet.subnet : "${vnet.id}/subnets/${s["name"]}"
#     ]
#   }
# }

# output "subnet_ids" {
#   value = local.subnet_ids["my-vnet"]
# }
