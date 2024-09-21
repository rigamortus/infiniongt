variable "config" {
  type = object({
    cluster = list(object({
      name                    = string
      location                = string
      resource_group_name     = string
      dns_prefix              = string
      kubernetes_version      = string
      rbac                    = optional(bool)
      sku                     = optional(string)
      private_cluster_enabled = bool
      noderg                  = string
      key_vault_secrets_provider = object({
        secret_rotation = bool
      })
      network_profile = object({
        network_plugin = string
        pod_cidr       = optional(string)
        service_cidr   = string
        dns_service_ip = string
      })
      api_server_access_profile = object({
        authorized_ip_ranges = list(string)
      })
      identity = object({
        type = string
      })
      ingressApplicationGateway = object({
        gatewayName = string
        subnetId    = string
      })
      default_node_pool = object({
        name       = string
        node_count = string
        vm_size    = string
        os_sku     = string
        vnet_subnet_id = string
      })
      tags = optional(map(string))
    }))
  })
}

variable "subnet_ids" {
  type = map(string)
}