resource "azurerm_private_dns_zone" "zone" {
  for_each            = { for x in var.config.privdns : x.name => x }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

output "pvdns_name" {
  value = { for name, privdns in azurerm_private_dns_zone.zone : name => privdns.name }
}

output "pvzones" {
  value = { for name, privdns in azurerm_private_dns_zone.zone : name => privdns.id }
}