resource "azurerm_kubernetes_cluster" "aks" {
  for_each                          = { for x in var.config.cluster : x.name => x }
  name                              = each.value.name
  location                          = each.value.location
  resource_group_name               = each.value.resource_group_name
  dns_prefix                        = each.value.dns_prefix
  kubernetes_version                = each.value.kubernetes_version
  private_cluster_enabled           = each.value.private_cluster_enabled
  role_based_access_control_enabled = each.value.rbac
  sku_tier                          = each.value.sku
  node_resource_group               = each.value.noderg
  key_vault_secrets_provider {
    secret_rotation_enabled = each.value.key_vault_secrets_provider.secret_rotation
  }
  default_node_pool {
    name       = each.value.default_node_pool.name
    node_count = each.value.default_node_pool.node_count
    vm_size    = each.value.default_node_pool.vm_size
    os_sku     = each.value.default_node_pool.os_sku
    vnet_subnet_id = var.subnet_ids[each.value.default_node_pool.vnet_subnet_id]
  }
  network_profile {
    network_plugin = each.value.network_profile.network_plugin
    pod_cidr       = each.value.network_profile.pod_cidr
    service_cidr   = each.value.network_profile.service_cidr
    dns_service_ip = each.value.network_profile.dns_service_ip
  }

  api_server_access_profile {
    authorized_ip_ranges = each.value.api_server_access_profile.authorized_ip_ranges
  }

  identity {
    type = each.value.identity.type
  }

  ingress_application_gateway {
    gateway_name = each.value.ingressApplicationGateway.gatewayName
    subnet_id    = var.subnet_ids[each.value.ingressApplicationGateway.subnetId]
  }

  tags = each.value.tags
}

output "kubernetes_cluster_id" {
  value = { for name, cluster in azurerm_kubernetes_cluster.aks : name => cluster.id }
}

output "kubelet_identity" {
  value = { for name, cluster in azurerm_kubernetes_cluster.aks: name => cluster.kubelet_identity.object_id }
}