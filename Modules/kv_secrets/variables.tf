variable "key_vault_secrets" {
    description = "A map of secrets to create in the Key Vault"
    type = map(object({
        name = string
        value = string
        kv_key = string
    }))
}

variable "kv_ids" {
  type = map(string)
}