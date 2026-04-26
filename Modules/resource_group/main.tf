resource "azurerm_resource_group" "rg_aks" {
    for_each = var.resource_groups
    name     = each.value.name
    location = each.value.location
    managed_by = lookup(each.value, "managed_by", null)
    tags = lookup(each.value, "tags", null)
  
}

output "rg_ids" {
    value = { for k, v in azurerm_resource_group.rg_aks : k => v.id }
}

output "rg_names" {
    value = { for k, v in azurerm_resource_group.rg_aks : k => v.name }
}

output "rg_locations" {
    value = { for k, v in azurerm_resource_group.rg_aks : k => v.location }
}