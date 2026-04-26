

########################################
# ACR VARIABLES
########################################

variable "container_registries" {
  description = "ACR configuration"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    tags                = optional(map(string))
  }))
}
