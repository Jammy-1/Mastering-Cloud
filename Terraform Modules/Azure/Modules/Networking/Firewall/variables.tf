variable "resource_group_name" { type        = string }
variable "location" { type  = string }
variable "vnet_name" { type        = string }
variable "vnet_address_space" { type        = list(string) }
variable "regular_subnet_name" { type        = string }
variable "regular_subnet_prefix" { type        = string }
variable "nsg_name" { type        = string }
variable "firewall_subnet_prefix" { type        = string }
variable "firewall_name" { type        = string }
variable "firewall_public_ip_name" { type        = string }

variable "firewall_network_rules" {
  type = list(object({
    name                 = string
    source_addresses     = list(string)
    destination_addresses = list(string)
    destination_ports     = list(string)
    protocols             = list(string)
    action                = string 
    priority              = number
  }))
}
