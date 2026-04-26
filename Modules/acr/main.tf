
#################### ACR #########################


resource "azurerm_container_registry" "acr" {
    for_each = var.container_registries
        name                = each.value.name
        location            = each.value.location
        resource_group_name = each.value.resource_group_name
        sku                 = each.value.sku
        admin_enabled       = false
        tags                = try(each.value.tags, null)  
  
}

output "acr_ids" {
    value = { for k, v in azurerm_container_registry.acr : k => v.id }
  
}

output "acr_login_server" {
    value = { for k, v in azurerm_container_registry.acr : k => v.login_server }
}
