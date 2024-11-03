variable "config" {
  type = object({
    roles = list(object({
      principal_id                     = string
      role_definition_name             = string
      scope                            = string
      skip_service_principal_aad_check = bool
    }))
  })
}

variable "acr_id" {
  type = map(string)
}

variable "keyvault_id" {
  type = map(string)
}

variable "kubelet_identity" {
  type = map(string)
}