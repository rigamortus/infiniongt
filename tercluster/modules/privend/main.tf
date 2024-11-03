resource "azurerm_private_endpoint" "endpoints" {
  for_each            = { for x in var.config.endpoints : x.name => x }
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = var.subnet_id[each.value.subnet_id]

  private_service_connection {
    name                           = each.value.private_service_connection.name
    private_connection_resource_id = each.value.name == "myacrendpoint" ? var.acr_id[each.value.private_service_connection.private_connection_resource_id] : var.keyvault_id[each.value.private_service_connection.private_connection_resource_id]
    subresource_names              = [each.value.private_service_connection.subresource_names]
    is_manual_connection           = each.value.private_service_connection.is_manual_connection
  }

  private_dns_zone_group {
    name = each.value.private_dns_zone_group.name

    private_dns_zone_ids = [var.pvzones[each.value.private_dns_zone_group.private_dns_zone_ids]]
  }
}