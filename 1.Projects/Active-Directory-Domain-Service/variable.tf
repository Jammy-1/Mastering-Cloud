# Resource Group
variable "resource_group" { type = string }
variable "location" { type = string }

# Network
variable "vnet_name" { type = string }
variable "address_spaces" { type = list(string) }

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

