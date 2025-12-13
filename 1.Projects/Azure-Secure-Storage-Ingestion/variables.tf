# General
variable "location" { type = string }
variable "global_tags" { type = map(string) }

# Tags
variable "resource_group_tags"  { type = map(string) }
variable "key_vault_tags"       { type = map(string) }
variable "nsg_tags"             { type = map(string) }
variable "network_tags"         { type = map(string) }
variable "vpn_tags"             { type = map(string) }
variable "storage_tags"         { type = map(string) }
variable "vm_tags"              { type = map(string) }

# Resource Groups
variable "rg_core_name" { type = string }
variable "rg_network_name" { type = string }
variable "rg_compute_name" { type = string }
variable "rg_storage_name" { type = string }
variable "rg_security_name" { type = string }

# Key Vault
variable "key_vault_name" { type = string }
variable "key_vault_secret_vpn_shared_key_name" { type = string }
variable "key_vault_secret_vm_disk_key" { type = string }

variable "key_vault_sku" { type = string }
variable "soft_delete_retention_days" { type = number }
variable "purge_protection" { type = bool }
variable "public_network_access_enabled" { type = bool }
variable "rbac_authorization_enabled" { type = bool }

# NSG
variable "nsg_name" { type = string }

variable "cloud_cidr" { type = string }
variable "on_prem_public_ip" { type = string }
variable "storage_private_endpoint_subnet_cidr" { type = string }
variable "dns_servers_cidr" { type = list(string) }

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

# Network
variable "vnet_name" { type = string }
variable "vm_address_space" { type = list(string) }
variable "vm_subnet_name" { type = string }
variable "vm_subnet_cidr" { type = string }

variable "private_endpoint_subnet_name" { type = string }
variable "private_endpoint_subnet_cidr" { type = string }

variable "gateway_subnet_name" { type = string }
variable "gateway_subnet_cidr" { type = string }

# VPN
variable "vpn_gateway_name" { type = string }
variable "vpn_type" { type = string }
variable "public_ip_name" { type = string }
variable "public_ip_allocation_method" { type = string }
variable "public_ip_sku" { type = string }
variable "network_vpn_gateway_type" { type = string }
variable "vpn_gateway_type" { type = string }
variable "vpn_sku" { type = string }
variable "on_prem_gateway_name" { type = string }
variable "on_prem_address_space" { type = string }
variable "vpn_name" { type = string }
variable "vpn_shared_key" { 
  type = string 
  sensitive   = true
}

# Storage
variable "storage_account_name" { type = string }
variable "blob_container_name" { type = string }
variable "archive_days" {
  type    = number
  default = 30
}

# VM 
variable "vm_name" { type = string }
variable "vm_size" { type    = string }

variable "admin_username" { type = string }
variable "ssh_public_key_path" { type = string }

variable "nas_host" { type = string }
variable "nas_share" { type = string }
variable "nas_username" {
  type        = string
  sensitive   = true
}

variable "nas_password" {
  type        = string
  sensitive   = true
}