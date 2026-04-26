resource "azurerm_public_ip" "appgw_pip" {
  for_each            = var.app_gateways
  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = try(each.value.tags, {})
}

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gateways
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }

  gateway_ip_configuration {
    name      = "gw-ip-config"
    subnet_id = each.value.subnet_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip[each.key].id
  }

  backend_address_pool {
    name = "default-backend-pool"
  }

  backend_http_settings {
    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "default-backend-pool"
    backend_http_settings_name  = "http-setting"
    priority                   = 100
  }

  tags = try(each.value.tags, {})
}

output "appgw_ids" {
  value = {
    for k, v in azurerm_application_gateway.appgw : k => v.id
  }
}

output "appgw_public_ips" {
  value = {
    for k, v in azurerm_public_ip.appgw_pip : k => v.ip_address
  }
}

