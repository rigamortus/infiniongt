resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each = { for x in var.config.nodes : x.name => x }

  kubernetes_cluster_id  = var.kubernetes_cluster_id[each.value.cluster_name]
  name                   = each.value.name
  node_count             = each.value.node_count
  vm_size                = each.value.node_size
  mode                   = each.value.mode
  max_pods               = each.value.max_pods_per_node
  auto_scaling_enabled   = each.value.autoscaling
  min_count              = each.value.autoscaling ? each.value.node_count : null
  max_count              = each.value.autoscaling ? each.value.node_count * 2 : null
  os_disk_size_gb        = each.value.os_disk_size
  os_disk_type           = each.value.os_disk_type
  vnet_subnet_id         = var.subnet_ids[each.value.vnet_subnet_id]
  node_taints            = each.value.node_taints
  node_public_ip_enabled = each.value.public_ips
  node_labels            = each.value.node_labels
}