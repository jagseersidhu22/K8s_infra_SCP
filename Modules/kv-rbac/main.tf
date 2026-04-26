resource "azurerm_role_assignment" "kv_rbac" {

  for_each = var.enable_aks_access ? var.kv_ids : {}

  scope                = each.value
  principal_id         = var.aks_sp_object_id
  role_definition_name = "Key Vault Secrets User"
}