resource "azurerm_key_vault" "aks_kv" {
    for_each = var.key_vaults
        name                = each.value.name
        location            = each.value.location
        resource_group_name = each.value.resource_group_name
        tenant_id           = each.value.tenant_id
        sku_name            = each.value.sku_name
        tags                = try(each.value.tags, null)
  
  enable_rbac_authorization = true
}

output "kv_ids" {
    value = { for k, v in azurerm_key_vault.aks_kv : k => v.id }
  
}

output "kv_names" {
    value = { for k, v in azurerm_key_vault.aks_kv : k => v.name }
  
}

