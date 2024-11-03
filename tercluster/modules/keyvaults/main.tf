resource "azurerm_key_vault" "key_vault" {
  for_each                    = { for x in var.config.vaults : x.name => x }
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.disk_encryption
  tenant_id                   = each.value.tenant_id
  soft_delete_retention_days  = each.value.retention
  purge_protection_enabled    = each.value.purge_protection_enabled
  sku_name                    = each.value.sku

  network_acls {
    default_action             = each.value.network_acls.default_action
    bypass                     = each.value.network_acls.bypass
    virtual_network_subnet_ids = [var.subnet_id[each.value.network_acls.virtual_network_subnet_ids]]
    ip_rules                   = [each.value.network_acls.ip_rules] #"4.245.217.88"
  }

  access_policy {
    tenant_id = each.value.access_policy.tenant_id
    object_id = each.value.access_policy.object_id

    key_permissions = each.value.access_policy.key_permissions

    secret_permissions = each.value.access_policy.secret_permissions

    storage_permissions = each.value.access_policy.storage_permissions
  }

  #depends_on = [azurerm_subnet.endpoint]
}

output "keyvault_id" {
    value = { for name, keyvault in azurerm_key_vault.key_vault : name => keyvault.id }
}