##### RG variables #####
variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  
}

variable "rg_location" {
  description = "Location of the resource group"
  type        = string
  
}

##### VNET variables #####

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}


variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  
}


##### Subnet variables #####

variable "subnet_name_aks" {
  description = "Name of the subnet"
  type        = string

}

variable "subnet_address_prefixes_aks" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  
}

variable "subnet_name_app_gw" {
  description = "Name of the subnet for Application Gateway"
  type        = string
}

variable "subnet_address_prefixes_app_gw" {
  description = "Address prefixes for the Application Gateway subnet"
  type        = list(string)

}

variable "subnet_name_fw" {
  description = "Name of the subnet for Azure Firewall"
  type        = string

}

variable "subnet_address_prefixes_fw" {
  description = "Address prefixes for the Azure Firewall subnet"
  type        = list(string)
 
}

variable "subnet_name_private_endpoints" {
  description = "Name of the subnet for private endpoints"
  type        = string
  
}

variable "subnet_address_prefixes_private_endpoints" {
  description = "Address prefixes for the private endpoints subnet"
  type        = list(string)
  
}


#######acr variables #####


variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "acr_sku" {
  description = "SKU for the Azure Container Registry"
  type        = string
}

variable "acr_tags" {
  description = "Tags for the Azure Container Registry"
  type        = map(string)

}


######aks variables #####

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "aks_node_count" {
  description = "Number of nodes in the AKS cluster"
  type        = number
}

variable "aks_vm_size" {
  description = "Size of the VMs in the AKS cluster"
  type        = string
}


variable "aks_tags" {
  description = "Tags for the AKS cluster"
  type        = map(string)
}


###### kv variables #####

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
  
}

variable "kv_sku_name" {
  description = "SKU name for the Key Vault"
  type        = string
}

variable "kv_tags" {
  description = "Tags for the Key Vault"
  type        = map(string)
}


###### sql server and database variables #####

variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_server_version" {
  description = "Version of the SQL server"
  type        = string
}

variable "sql_admin_login" {
  description = "Login for the SQL server administrator"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "sql_database_sku_name" {
  description = "SKU name for the SQL database"
  type        = string
}

variable "sql_database_max_size_gb" {
  description = "Maximum size of the SQL database in GB"
  type        = number
}

variable "sql_database_collation" {
  description = "Collation for the SQL database"
  type        = string
}

variable "sql_database_zone_redundant" {
  description = "Whether the SQL database is zone redundant"
  type        = bool
}

variable "sql_database_read_scale" {
  description = "Whether the SQL database supports read scale"
  type        = bool
}

variable "sql_server_tags" {
  description = "Tags for the SQL server"
  type        = map(string)
}

variable "sql_database_tags" {
  description = "Tags for the SQL database"
  type        = map(string)
}


variable "db_password_from_pipeline" {
  type      = string
  sensitive = true
}


###### app gateway variables #####
variable "app_gw_name" {
  description = "Name of the Application Gateway"
  type        = string
}

