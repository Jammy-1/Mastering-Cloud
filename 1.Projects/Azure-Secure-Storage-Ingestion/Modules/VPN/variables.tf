# General
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

#Public IP
variable "public_ip_allocation_method" { type = string }
variable "public_ip_sku" { type = string }
variable "public_ip_name" { type = string }

#VPN Gateway
variable "vpn_gateway_name" { type = string }
variable "network_vpn_gateway_type" { type = string }
variable "vpn_gateway_type" { type = string }  
variable "vpn_sku" { type = string }

# On Prem Gateway
variable "on_prem_gateway_name" { type = string }
variable "on_prem_public_ip" { type = string }
variable "on_prem_address_space" { type = string }

# VPN Connection Settings
variable "vpn_name" { type = string }
variable "vpn_type" { type = string }
variable "vpn_shared_key" { 
    type = string
    sensitive = true
}

# Subnet
variable "gateway_subnet" { type = string }
