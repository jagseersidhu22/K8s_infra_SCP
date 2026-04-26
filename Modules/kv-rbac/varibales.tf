variable "kv_ids" {
  type = map(string)
}

variable "aks_sp_object_id" {
  type = string
}

variable "enable_aks_access" {
  type = bool
}