variable "virtual_networks" {
    description = "A map of virtual networks to create"
    type        = map(object({
        name                = string
        address_space       = list(string)
        location            = string
        resource_group_name = string
        tags                = optional(map(string))
    }))
  
}


variable "subnets" {
    description = "A map of subnets to create"
    type        = map(object({
        name                 = string
        resource_group_name  = string
        virtual_network_name = string
        address_prefixes     = list(string)
    }))
  
}
