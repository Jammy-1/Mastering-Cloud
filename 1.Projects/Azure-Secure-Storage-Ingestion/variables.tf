# General
variable "location" { type = string }
variable "tags" { type = map(string) }

# Resource Groups
variable "rg_core_name" { type = string }
variable "rg_network_name" { type = string }
variable "rg_compute_name" { type = string }
variable "rg_storage_name" { type = string }
variable "rg_security_name" { type = string }

# Key Vault
variable "key_vault_name" { type = string }
variable "key_vault_secret_vpn_shared_key_name" { type = string }
variable "key_vault_secret_vm_disk_key"{ type = string }

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
variable "public_ip_name" { type = string }
variable "public_ip_allocation_method" { type = string }
variable "public_ip_sku" { type = string }
variable "network_vpn_gateway_type" { type = string }
variable "vpn_gateway_type" { type = string }
variable "vpn_sku" { type = string }
variable "on_prem_gateway_name" { type = string }
variable "on_prem_address_space" { type = string }
variable "vpn_name" { type = string }
variable "vpn_shared_key" { type = string }
variable "vpn_type" { type = string }


