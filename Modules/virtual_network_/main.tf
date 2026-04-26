resource "azurerm_virtual_network" "vnet_aks" {

  for_each = var.virtual_networks
    name                = each.value.name
    address_space       = each.value.address_space
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    tags = lookup(each.value, "tags", null)


}



output "vnet_ids" {
    value = { for k, v in azurerm_virtual_network.vnet_aks : k => v.id }
  
}

output "vnet_names" {
    value = { for k, v in azurerm_virtual_network.vnet_aks : k => v.name }
  
}


#########################################Subnet##########################################################################
resource "azurerm_subnet" "aks_subnet" {
  for_each = var.subnets
    name                 = each.value.name
    resource_group_name  = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name
    address_prefixes     = each.value.address_prefixes
  
}


output "subnet_ids" {   
    value = { for k, v in azurerm_subnet.aks_subnet : k => v.id }
  
}
