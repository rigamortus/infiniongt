resource "azurerm_container_registry" "acr" {
  for_each                      = { for x in var.config.acr : x.name => x }
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  sku                           = each.value.sku
  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  network_rule_bypass_option    = "AzureServices"
  network_rule_set {
    default_action = each.value.network_rule_set.default_action
    ip_rule {
      action   = each.value.network_rule_set.ip_rule.action
      ip_range = each.value.network_rule_set.ip_rule.ip_range
    }
  }
}

output "acr_id" {
  value = { for name, acr in azurerm_container_registry.acr : name => acr.id }
}