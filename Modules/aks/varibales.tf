########################################
# AKS VARIABLES
########################################

variable "aks_clusters" {
  description = "AKS clusters configuration"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string

    default_node_pool = object({
      name       = string
      node_count = number
      vm_size    = string
      subnet_id = string
    })

    network_profile = object({
      network_plugin    = string
      load_balancer_sku = string
      outbound_type     = string
      service_cidr      = string
      dns_service_ip    = string
    })

    tags = optional(map(string))
  }))
}

variable "appgw_subnet_id" {
  description = "Subnet ID for Application Gateway"
  type        = string
}