resource "azurerm_kubernetes_cluster" "aks_cluster" {
    for_each = var.aks_clusters
    name                = each.value.name
    location            = each.value.location
    resource_group_name = each.value.resource_group_name
    dns_prefix          = each.value.dns_prefix
    default_node_pool {
        name       = each.value.default_node_pool.name
        node_count = each.value.default_node_pool.node_count
        vm_size    = each.value.default_node_pool.vm_size
        vnet_subnet_id = each.value.default_node_pool.subnet_id
    }
    identity {
        type = "SystemAssigned"
    }
     network_profile {
    network_plugin    = each.value.network_profile.network_plugin
    load_balancer_sku = each.value.network_profile.load_balancer_sku
    outbound_type     = each.value.network_profile.outbound_type
    service_cidr = each.value.network_profile.service_cidr
    dns_service_ip = each.value.network_profile.dns_service_ip
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  
  ingress_application_gateway {
    subnet_id = var.appgw_subnet_id
  }
    tags = try(each.value.tags, {})


}



output "aks_cluster_ids" {
    value = { for k, v in azurerm_kubernetes_cluster.aks_cluster : k => v.id }
  
}

output "aks_principal_ids" {
    value = { for k, v in azurerm_kubernetes_cluster.aks_cluster : k => v.identity[0].principal_id }
  
}

output "kubelet_object_ids" {
  value = {
    for k, v in azurerm_kubernetes_cluster.aks_cluster :
    k => v.kubelet_identity[0].object_id
  }
}
