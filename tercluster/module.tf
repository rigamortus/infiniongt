module "clusters" {
  source     = "./modules/clusters"
  config     = local.env.aks-clusters
  subnet_ids = module.subnets.subnet_id
}


module "node_pools" {
  source                = "./modules/nodepools"
  config                = local.env.node_pools
  kubernetes_cluster_id = module.clusters.kubernetes_cluster_id
  subnet_ids            = module.subnets.subnet_id
}

module "vnets" {
  source = "./modules/vnet"
  config = local.env.virtual_networks
}

module "subnets" {
  source = "./modules/subnets"
  config = local.env.virtual_subnets
}
module "network_security_group" {
  source = "./modules/nsg"
  config = local.env.network_security_groups
}

module "private_dns_zone" {
  source = "./modules/privdns"
  config = local.env.private_dns_zones
}

module "private_dns_link" {
  source     = "./modules/privdnslinks"
  config     = local.env.privdns_net_links
  vnet_id    = module.vnets.vnet_id
  pvdns_name = module.private_dns_zone.pvdns_name
}

module "pvendpoints" {
  source      = "./modules/privend"
  config      = local.env.priv_endpoints
  subnet_id   = module.subnets.subnet_id
  pvzones     = module.private_dns_zone.pvzones
  acr_id      = module.acr.acr_id
  keyvault_id = module.kvs.keyvault_id
}

module "kvs" {
  source    = "./modules/keyvaults"
  config    = local.env.key_vaults
  subnet_id = module.subnets.subnet_id
}

module "acr" {
  source = "./modules/acr"
  config = local.env.acrs
}

module "roleassignments" {
  source           = "./modules/roleassignment"
  config           = local.env.role_assignments
  acr_id           = module.acr.acr_id
  keyvault_id      = module.kvs.keyvault_id
  kubelet_identity = module.clusters.kubelet_identity
}