resource "azurerm_subnet" "mysub" {
  for_each             = { for x in var.config.subnets : x.name => x }
  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = [each.value.address_prefixes]
}

output "subnet_id" {
  value = { for name, subnet in azurerm_subnet.mysub : name => subnet.id }
}