variable "ARM_SUBSCRIPTION_ID" {
  type        = string
  default     = "01865a64-1974-4037-8780-90e5bebf910e"
  description = "description"
}

variable "ARM_TENANT_ID" {
  type        = string
  default     = "215b7ce2-5263-4593-a622-da030405d151"
  description = "description"
}

variable "nsg_name" {
  type    = string
  default = "my-nsg"
}

variable "kv_private_dns_zone" {
  default = "mydns.privatelink.azure.com"
}

variable "acr_dns" {
  default = "myacrdns.privatelink.azure.com"
}

variable "key_vault_name" {
  default = "myrigamortuskeyvault"
}

variable "key_vault_endpoint" {
  default = "mykeyendpoint"
}

variable "key_vault_service_connection" {
  default = "keyvaultservconnect"
}

variable "container_registry_endpoint" {
  default = "myacrendpoint"
}

variable "container_registry_service_connection" {
  default = "myacrserviceconnect"
}