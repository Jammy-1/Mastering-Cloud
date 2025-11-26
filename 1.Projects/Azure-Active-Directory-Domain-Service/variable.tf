# Resource Group
variable "resource_group" { type = string }
variable "location" { type = string }

# AADS
variable "aadds_name" { type = string }
variable "domain_name" { type = string }
variable "sku" { type = string }
variable "filtered_sync_enabled" { type = bool }
variable "additional_recipients" { type = list(string) }
variable "notify_dc_admins" { type = bool }
variable "notify_global_admins" { type = bool }
variable "sync_kerberos_passwords" { type = bool }
variable "sync_ntlm_passwords" { type = bool }
variable "sync_on_prem_passwords" { type = bool }
variable "dc_admin_upn" { type = string }
variable "dc_admin_display_name" { type = string }
variable "dc_admin_password" { type = string }

# Network
variable "vnet_name" { type = string }
variable "address_spaces" { type = list(string) }
variable "dns_servers" { type = list(string) }

# NSG
variable "nsg_name" { type = string }

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    attach_nsg       = optional(bool, true)
  }))
}

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
}
