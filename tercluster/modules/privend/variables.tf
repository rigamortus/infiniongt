variable "config" {
  type = object({
    endpoints = list(object({
      name                = string
      location            = string
      resource_group_name = string
      subnet_id           = string
      private_service_connection = object({
        name                           = string
        private_connection_resource_id = string
        subresource_names              = optional(string)
        is_manual_connection           = bool
      })
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = string
      }))
    }))
  })
}

variable "pvzones" {
  type = map(string)
}

variable "subnet_id" {
  type = map(string)
}

variable "acr_id" {
  type = map(string)
}

variable "keyvault_id" {
  type = map(string)
}