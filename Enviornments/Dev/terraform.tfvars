# Value for the RG name
rg_name = "rg-aks-dev"

# Azure location for the RG
rg_location = "australiaeast"

# Values for the VNET
vnet_name = "vnet-aks-dev"

vnet_address_space = [ "10.0.0.0/16" ]

# Values for the Subnet
subnet_name_aks = "subnet-aks-dev"
subnet_address_prefixes_aks = [ "10.0.0.0/24" ]
subnet_name_app_gw = "subnet_aks_gw-dev"
subnet_address_prefixes_app_gw = [ "10.0.1.0/24" ]
subnet_name_fw = "AzureFirewallSubnet"
subnet_address_prefixes_fw = [ "10.0.2.0/24" ]
subnet_name_private_endpoints = "snet-private-endpoints-dev"
subnet_address_prefixes_private_endpoints = [ "10.0.3.0/24" ]


###acr values

acr_name = "acrdevjg"
acr_sku = "Standard"
acr_tags = {
  Environment = "Dev"
}



##### aks values

aks_cluster_name = "aks-dev-jg"
aks_dns_prefix = "aksdevjg"
aks_node_count = 3
aks_vm_size = "Standard_D2s_v3"
aks_tags = {
  Environment = "Dev"
}





###### Values for the Kv

kv_name = "kv-aks-dev"
kv_sku_name = "standard"
kv_tags = {
   Environment = "Dev"
}


# sql server & database values

sql_server_name = "sql-aks-dev"
sql_server_version = "12.0"
sql_admin_login = "sqladminuser"
sql_database_name = "aksdb"
sql_database_sku_name = "S0"
sql_database_max_size_gb = 5
sql_database_collation = "SQL_Latin1_General_CP1_CI_AS"
sql_database_zone_redundant = false
sql_database_read_scale = false
sql_server_tags = {
  Environment = "Dev"
}
sql_database_tags = {
  Environment = "Dev"
}

app_gw_name = "appgw-aks-dev"

