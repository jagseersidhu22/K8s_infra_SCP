variable "key_vaults" {
    description = "A map of key vaults to create"
    type        = map(object({
        name                = string
        location            = string
        resource_group_name = string
        tenant_id           = string
        sku_name            = string
        tags                = optional(map(string))
    }))
  
}

variable "kv_enable_rbac_authorization" {
    description = "Whether to enable RBAC authorization for the Key Vault"
    type        = bool
}