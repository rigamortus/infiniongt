variable "config" {
  type = object({
    pvlinks = list(object({
      name                  = string
      private_dns_zone_name = string
      resource_group_name   = string
      virtual_network_id    = string
    }))
  })
}

variable "pvdns_name" {
  type = map(string)
}

variable "vnet_id" {
  type = map(string)
}