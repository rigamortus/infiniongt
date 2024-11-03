variable "config" {
  type = object({
    privdns = list(object({
      name                = string
      resource_group_name = string
    }))
  })
}