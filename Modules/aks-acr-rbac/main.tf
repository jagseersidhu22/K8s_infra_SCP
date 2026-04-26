resource "azurerm_role_assignment" "acr_pull" {

  for_each = var.enable_acr_rbac ? var.rbac_map : {}

  principal_id = var.aks_principal_ids[each.value.aks_key]

  role_definition_name = "AcrPull"

  scope = var.acr_ids[each.value.acr_key]
}