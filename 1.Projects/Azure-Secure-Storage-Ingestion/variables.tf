# General
variable "location" { type = string }
variable "tags" { type = map(string) }

# Resource Groups
variable "rg_core_name" { type = string }
variable "rg_network_name" { type = string }
variable "rg_compute_name" { type = string }
variable "rg_storage_name" { type = string }
variable "rg_security_name" { type = string }

# NSG
variable "nsg_name" { type = string }

variable "cloud_cidr" { type = string }
variable "on_prem_cidr" { type = string }
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
