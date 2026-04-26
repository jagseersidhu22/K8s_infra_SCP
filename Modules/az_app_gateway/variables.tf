variable "app_gateways" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string

    sku = object({
      name     = string
      tier     = string
      capacity = number
    })

    tags = optional(map(string))
  }))
}