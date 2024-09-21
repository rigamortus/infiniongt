variable "config" {
  type = object({
    nodes = list(object({
      cluster_name      = string
      name              = string
      node_count        = number
      node_size         = string
      mode              = string
      max_pods_per_node = number
      autoscaling       = bool
      min_count         = optional(number)
      max_count         = optional(number)
      os_disk_size      = number
      os_disk_type      = string
      vnet_subnet_id    = string
      node_taints       = list(string)
      public_ips        = bool
      node_labels       = optional(map(string))
      zones             = optional(string)
    }))
  })
}
variable "kubernetes_cluster_id" {
  type = map(string)
}


variable "subnet_ids" {
  description = "Map of subnet IDs to be used for each node pool"
  type        = map(string)
}