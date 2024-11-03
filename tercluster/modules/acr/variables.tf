variable "config" {
  type = object({
    acr = list(object({
      name                          = string
      resource_group_name           = string
      location                      = string
      sku                           = string
      admin_enabled                 = string
      public_network_access_enabled = bool
      network_rule_bypass_option    = string
      network_rule_set = object({
        default_action = string
        ip_rule = object({
          action   = string
          ip_range = string
        })
      })
    }))
  })
}