# General
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

# Key Vault
variable "key_vault_name" { type = string }
variable "key_vault_secret_vpn_shared_key_name" { type = string }
variable "key_vault_secret_vm_disk_key"{ type = string }

variable "key_vault_sku" { type = string }
variable "tenant_id" { type = string }

variable "soft_delete_retention_days" { type = number }
variable "purge_protection" { type = bool }
variable "public_network_access_enabled"  {type = bool }
variable "rbac_authorization_enabled" { type = bool }

variable "vpn_shared_key" {
  type      = string
  sensitive = true
}
variable "storage_identity_principal_id" { type = string }

variable "nas_username" {
  type        = string
  sensitive   = true
}

variable "nas_password" {
  type        = string
  sensitive   = true
}