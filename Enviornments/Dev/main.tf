############# Resource Group #############

module "rg" {
    source = "../../Modules/resource_group"
    resource_groups = {
        rg_aks_dev = {
            name     = var.rg_name
            location = var.rg_location
        }
    }
  
}


##########  VNET  #############

module "vnet" {
    source = "../../Modules/virtual_network_"
    virtual_networks = {
        vnet_aks_dev = {
            name                = var.vnet_name
            resource_group_name = module.rg.rg_names["rg_aks_dev"]
            location            = var.rg_location
            address_space       = var.vnet_address_space
        }
    }

    subnets = {
        subnet_aks_dev = {
            name                 = var.subnet_name_aks
            resource_group_name  = module.rg.rg_names["rg_aks_dev"]
            virtual_network_name = var.vnet_name
            address_prefixes     = var.subnet_address_prefixes_aks
        }
    

        app_gw_subnet = {
            name                 = var.subnet_name_app_gw
            resource_group_name  = module.rg.rg_names["rg_aks_dev"]
            virtual_network_name = var.vnet_name
            address_prefixes     = var.subnet_address_prefixes_app_gw
        }

        azfirewall_subnet = {
            name                 = var.subnet_name_fw
            resource_group_name  = module.rg.rg_names["rg_aks_dev"]
            virtual_network_name = var.vnet_name
            address_prefixes     = var.subnet_address_prefixes_fw
    }

    private_endpoints_subnet = {
        name                 = var.subnet_name_private_endpoints
        resource_group_name  = module.rg.rg_names["rg_aks_dev"]
        virtual_network_name = var.vnet_name
        address_prefixes     = var.subnet_address_prefixes_private_endpoints
    }
}   

}



###########ACR ##################



module "acr" {
  source = "../../Modules/acr"
    container_registries = {
        acr_aks_dev = {
        name                = var.acr_name
        resource_group_name = module.rg.rg_names["rg_aks_dev"]
        location            = var.rg_location
        sku                 = var.acr_sku
        tags                = var.acr_tags
        }
    }

}

########AKS ##########

module "aks" {
    source = "../../Modules/aks"
    aks_clusters = {
        aks_cluster_dev = {
            name                = var.aks_cluster_name
            location            = var.rg_location
            resource_group_name = module.rg.rg_names["rg_aks_dev"]
            dns_prefix          = var.aks_dns_prefix
            default_node_pool = {
                name       = "default"
                node_count = var.aks_node_count
                vm_size    = var.aks_vm_size
                subnet_id = module.vnet.subnet_ids["subnet_aks_dev"]
            }
                network_profile = {
                    network_plugin    = "azure"
                    load_balancer_sku = "standard"
                    outbound_type     = "loadBalancer"
                    service_cidr      = "10.2.0.0/16"
                    dns_service_ip    = "10.2.0.10"
                }
            tags = var.aks_tags
        }
    }
appgw_subnet_id = module.vnet.subnet_ids["app_gw_subnet"]



}



#####rbac_acr-to-aks ###################
module "aks_acr_rbac" {
  source = "../../Modules/aks-acr-rbac"

  aks_principal_ids = module.aks.kubelet_object_ids
  acr_ids = module.acr.acr_ids
  enable_acr_rbac = true

  rbac_map = {
    aks_to_acr_dev = {
      aks_key = "aks_cluster_dev"
      acr_key = "acr_aks_dev"
    }
  }
}


###########  Key Vault  ##########

module "kv" {
    source = "../../Modules/kv"
    key_vaults = {
        kv_aks_dev = {
            name                = var.kv_name
            location            = var.rg_location
            resource_group_name = module.rg.rg_names["rg_aks_dev"]
            tenant_id           = data.azurerm_client_config.current.tenant_id
            sku_name            = var.kv_sku_name
            tags = var.kv_tags
        }
    }
  
    kv_enable_rbac_authorization = true

}


#rbac for AKS to access Key Vault secrets

module "kv_rbac" {
  source = "../../Modules/kv-rbac"

  kv_ids           = module.kv.kv_ids
  aks_sp_object_id = module.aks.kubelet_object_ids["aks_cluster_dev"]

  enable_aks_access = true
}




#kv_secretss


module "kv_secrets" {
    source = "../../Modules/kv_secrets"
    kv_ids = module.kv.kv_ids
    key_vault_secrets = {
        db_password = {
            name         = "db-password"
            value        = var.db_password_from_pipeline
            kv_key        = "kv_aks_dev"
        }

    }
  
}

 ######### DB #########

module "db" {
    source = "../../Modules/db"
    sql_servers = {
        sql_server_aks_dev = {
            name                         = var.sql_server_name
            resource_group_name          = module.rg.rg_names["rg_aks_dev"]
            location                     = var.rg_location
            version                      = var.sql_server_version
            administrator_login          = var.sql_admin_login
            administrator_login_password = var.db_password_from_pipeline
            tags                         = var.sql_server_tags
        }
    }

    sql_databases = {
        sql_database_aks_dev = {
            name          = var.sql_database_name
            server_key    = "sql_server_aks_dev"
            sku_name      = var.sql_database_sku_name
            max_size_gb   = var.sql_database_max_size_gb
            collation     = var.sql_database_collation
            zone_redundant = var.sql_database_zone_redundant
            read_scale     = var.sql_database_read_scale
            tags           = var.sql_database_tags
        }
    }
}
 

 ######app_gw ##############

module "app_gateway" {
    source = "../../Modules/az_app_gateway"
    app_gateways = {
        app_gw_aks_dev = {
            name                = var.app_gw_name
            location            = var.rg_location
            resource_group_name = module.rg.rg_names["rg_aks_dev"]
            subnet_id           = module.vnet.subnet_ids["app_gw_subnet"]
            sku = {
                name     = "Standard_v2"
                tier     = "Standard_v2"
                capacity = 2
            }
            tags                = {
                environment = "dev"
               
            }
        }
    }

}