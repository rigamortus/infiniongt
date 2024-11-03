variable "config" {
  type = object({
    vaults = list(object({
      name                        = string
      location                    = string
      resource_group_name         = string
      disk_encryption             = bool
      tenant_id                   = string
      retention                   = number
      purge_protection_enabled    = bool
      sku                         = string

      network_acls = object({
        default_action             = string
        bypass                     = string
        virtual_network_subnet_ids = string
        ip_rules                   = string
      })

      access_policy = object({
        tenant_id = string
        object_id = string

        key_permissions = list(string)

        secret_permissions = list(string)

        storage_permissions = list(string)
      })
    }))
  })
}

variable "subnet_id" {
  type = map(string)
}