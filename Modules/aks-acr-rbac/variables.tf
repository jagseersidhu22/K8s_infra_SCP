variable "rbac_map" {
  description = "Mapping of AKS to ACR"
  type = map(object({
    aks_key = string
    acr_key = string
  }))
}

variable "aks_principal_ids" {
  type = map(string)
}

variable "acr_ids" {
  type = map(string)
}

variable "enable_acr_rbac" {
  type = bool
}