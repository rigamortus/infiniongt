resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each              =  { for x in var.config.pvlinks : x.name => x }
  name                  = each.value.name
  private_dns_zone_name = var.pvdns_name[each.value.private_dns_zone_name]
  resource_group_name   = each.value.resource_group_name
  virtual_network_id    = var.vnet_id[each.value.virtual_network_id]

}