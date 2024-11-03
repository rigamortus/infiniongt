locals {
  env = yamldecode(file("env.yaml"))
}

# resource "azurerm_virtual_network" "myvnet" {
#   name                = "my-vnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = "North Europe"
#   resource_group_name = "myrg"
# }

# resource "azurerm_subnet" "my_subnet" {
#   name                 = "default"
#   resource_group_name  = "myrg"
#   virtual_network_name = azurerm_virtual_network.myvnet.name
#   address_prefixes     = ["10.0.0.0/24"]
# }

# resource "azurerm_subnet" "appgw" {
#   name                 = "appgw"
#   resource_group_name  = "myrg"
#   virtual_network_name = azurerm_virtual_network.myvnet.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_subnet" "endpoint" {
#   name                 = "privendp"
#   resource_group_name  = "myrg"
#   virtual_network_name = azurerm_virtual_network.myvnet.name
#   address_prefixes     = ["10.0.2.0/24"]
#   service_endpoints    = ["Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
# }

# resource "azurerm_network_security_group" "subnet_nsg" {
#   name                = var.nsg_name
#   location            = "north europe"
#   resource_group_name = "myrg"

#   security_rule {
#     name                       = "AllowInternetTraffic"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "65200-65535"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "subassociate" {
#   subnet_id                 = azurerm_subnet.my_subnet.id
#   network_security_group_id = azurerm_network_security_group.subnet_nsg.id
# }

# resource "azurerm_subnet_network_security_group_association" "subassociate2" {
#   subnet_id                 = azurerm_subnet.endpoint.id
#   network_security_group_id = azurerm_network_security_group.subnet_nsg.id
# }

# resource "azurerm_subnet_network_security_group_association" "subassociate3" {
#   subnet_id                 = azurerm_subnet.appgw.id
#   network_security_group_id = azurerm_network_security_group.subnet_nsg.id
# }

# resource "azurerm_private_dns_zone" "key_vault_dns" {
#   name                = var.kv_private_dns_zone
#   resource_group_name = "myrg"
# }

# # Creating ACR Private DNS Zone
# resource "azurerm_private_dns_zone" "acr_dns" {
#   name                = var.acr_dns
#   resource_group_name = "myrg"
# }

# resource "azurerm_key_vault" "key_vault" {
#   name                        = var.key_vault_name
#   location                    = "north europe"
#   resource_group_name         = "myrg"
#   enabled_for_disk_encryption = true
#   tenant_id                   = var.ARM_TENANT_ID
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false

#   sku_name = "standard"

#   network_acls {
#     default_action             = "Deny"
#     bypass                     = "AzureServices"
#     virtual_network_subnet_ids = [azurerm_subnet.endpoint.id]
#     ip_rules                   = ["4.245.217.88"]
#   }

#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     key_permissions = [
#       "Get",
#     ]

#     secret_permissions = [
#       "Get",
#       "Set"
#     ]

#     storage_permissions = [
#       "Get",
#     ]
#   }

#   depends_on = [azurerm_subnet.endpoint]
# }

# resource "azurerm_private_endpoint" "key_vault_endpoint" {
#   name                = var.key_vault_endpoint
#   location            = "north europe"
#   resource_group_name = "myrg"
#   subnet_id           = azurerm_subnet.endpoint.id

#   private_service_connection {
#     name                           = var.key_vault_service_connection
#     private_connection_resource_id = azurerm_key_vault.key_vault.id
#     subresource_names              = ["vault"]
#     is_manual_connection           = false
#   }
# }

# resource "azurerm_container_registry" "acr" {
#   name                          = "rigamoacr"
#   resource_group_name           = "myrg"
#   location                      = "north europe"
#   sku                           = "Premium"
#   admin_enabled                 = false
#   public_network_access_enabled = true
#   network_rule_bypass_option    = "AzureServices"
#   network_rule_set {
#     default_action = "Deny"
#     ip_rule {
#       action   = "Allow"
#       ip_range = "4.245.216.59"
#     }
#   }

# }
# resource "azurerm_private_dns_zone_virtual_network_link" "acr_private_dns_zone_virtual_network_link" {
#   name                  = "my-vnet-link"
#   private_dns_zone_name = azurerm_private_dns_zone.acr_dns.name
#   resource_group_name   = "myrg"
#   virtual_network_id    = azurerm_virtual_network.myvnet.id
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "key_vault_dns_zone_virtual_network_link" {
#   name                  = "kv-vnet-link"
#   private_dns_zone_name = azurerm_private_dns_zone.key_vault_dns.name
#   resource_group_name   = "myrg"
#   virtual_network_id    = azurerm_virtual_network.myvnet.id
# }

# resource "azurerm_private_endpoint" "acr_endpoint" {
#   name                = var.container_registry_endpoint
#   location            = "north europe"
#   resource_group_name = "myrg"
#   subnet_id           = azurerm_subnet.endpoint.id

#   private_service_connection {
#     name                           = var.container_registry_service_connection
#     private_connection_resource_id = azurerm_container_registry.acr.id
#     subresource_names              = ["registry"]
#     is_manual_connection           = false
#   }

#   private_dns_zone_group {
#     name = "my-dns-zone-group"

#     private_dns_zone_ids = [
#       azurerm_private_dns_zone.acr_dns.id
#     ]
#   }

#   depends_on = [
#     azurerm_virtual_network.myvnet,
#     azurerm_subnet.endpoint,
#     azurerm_container_registry.acr
#   ]
# }

# resource "azurerm_key_vault_access_policy" "aks_access" {
#   key_vault_id = azurerm_key_vault.key_vault.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = module.clusters.kubelet_identity["my-aks"]

#   # Specify the permissions for secrets
#   secret_permissions = [
#     "Get",
#     "List"
#   ]
# }

# resource "azurerm_role_assignment" "aks_keyvault_access" {
#   principal_id         = module.clusters.kubelet_identity["my-aks"]
#   role_definition_name = "Key Vault Secrets User"
#   scope                = azurerm_key_vault.key_vault.id
# }

# resource "azurerm_role_assignment" "myacrole" {
#   principal_id                     = module.clusters.kubelet_identity["my-aks"]
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.acr.id
#   skip_service_principal_aad_check = true
# }