# Azure Location
variable "location" { type = string }
variable "resource_group_name" { type = string }

# AVD Host Pool & Application 
variable "host_pool_name" { type = string }
variable "host_pool_type" { type = string }
variable "load_balancer_type" { type = string }
variable "application_group_name" { type = string }
variable "workspace_name" { type = string }


# VMSS 
variable "initial_instance_count" { type = number }
variable "min_instance_count" { type = number }
variable "max_instance_count" { type = number }
variable "admin_username" { type = string }
variable "admin_password" { type = string }


# Networking
variable "vnet_name"           { type = string }
variable "vnet_address_spaces" { type = list(string) }
variable "nsg_name"            { type = string }
variable "avd_subnet_id"       { type = string }

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

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    attach_nsg       = bool
  }))
}