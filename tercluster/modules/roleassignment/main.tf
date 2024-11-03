resource "azurerm_role_assignment" "roles" {
  for_each                         = { for x in var.config.roles : "${x.principal_id}_${x.role_definition_name}" => x }
  principal_id                     = var.kubelet_identity[each.value.principal_id]
  role_definition_name             = each.value.role_definition_name
  scope                            = each.value.role_definition_name == "Key Vault Secrets User" ? var.keyvault_id[each.value.scope] : var.acr_id[each.value.scope]
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check
}