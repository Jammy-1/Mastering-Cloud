variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "regular_subnet_name" {
  description = "Name of the regular subnet"
  type        = string
}

variable "regular_subnet_prefix" {
  description = "Address prefix for the regular subnet"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "firewall_subnet_prefix" {
  description = "Address prefix for the firewall subnet"
  type        = string
}

variable "firewall_name" {
  description = "Name of the Azure Firewall"
  type        = string
}

variable "firewall_public_ip_name" {
  description = "Name of the public IP for the firewall"
  type        = string
}


variable "firewall_network_rules" {
  description = "List of network rules for the firewall (source, destination, ports, protocols)"
  type = list(object({
    name                 = string
    source_addresses     = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
    protocols             = list(string)
    action                = string  # "Allow" or "Deny"
    priority              = number
  }))
}
