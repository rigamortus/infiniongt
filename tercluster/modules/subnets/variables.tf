variable "config" {
  type = object({
    subnets = list(object({
      name                 = string
      resource_group_name  = string
      virtual_network_name = string
      address_prefixes     = string
    }))
  })
}