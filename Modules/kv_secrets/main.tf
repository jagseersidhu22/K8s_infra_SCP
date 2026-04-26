resource "azurerm_key_vault_secret" "kv_secrets" {
  for_each = var.key_vault_secrets

  name         = each.value.name
  value        = each.value.value
  key_vault_id = var.kv_ids[each.value.kv_key]
}

