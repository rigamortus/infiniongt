module "clusters" {
  source = "./modules/clusters"
  config = local.env.aks-clusters
  subnet_ids = {
    appgw   = azurerm_subnet.appgw.id
    default = azurerm_subnet.my_subnet.id
  }
}


module "node_pools" {
  source                = "./modules/nodepools"
  config                = local.env.node_pools
  kubernetes_cluster_id = module.clusters.kubernetes_cluster_id
  subnet_ids = {
    default = azurerm_subnet.my_subnet.id
  }
}