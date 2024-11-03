variable "config" {
  type = object({
    vnets = list(object({
      name                = string
      address_space       = list(string)
      vnet_prefix = optional(string)
      location            = string
      resource_group_name = string
      # subnet = list(object({
      #   name = string
      #   address_prefix = list(string)
      #   service_endpoints = list(string)
      # }))
      tags                = map(string)
    }))
  })
}