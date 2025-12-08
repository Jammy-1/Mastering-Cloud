# Security Rules
locals {
  default_security_rules = [
    {
      name                       = "Allow-SSH-Admin"
      priority                   = 4087
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = var.cloud_cidr
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-Storage-HTTPS"
      priority                   = 4093
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = var.storage_private_endpoint_subnet_cidr
    },
    {
      name                       = "Allow-SMB-To-OnPrem"
      priority                   = 4092
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "445"
      source_address_prefix      = "*"
      destination_address_prefix = var.on_prem_public_ip
    },
    {
      name                       = "Allow-VPN-From-OnPrem"
      priority                   = 4094
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = var.on_prem_public_ip
      destination_address_prefix = "*"
    },

    {
      name                       = "Allow-DNS"
      priority                   = 4091
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "53"
      source_address_prefix      = "*"
      destination_address_prefix = "168.63.129.16/32"
    },
    {
      name                       = "Allow-DNS-TCP"
      priority                   = 4090
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "53"
      source_address_prefix      = "*"
      destination_address_prefix = "168.63.129.16/32"
    },
    {
      name                       = "Allow-NTP"
      priority                   = 4089
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "123"
      source_address_prefix      = "*"
      destination_address_prefix = "168.63.129.16/32"
    },
    {
      name                       = "Allow-HTTPS-Updates"
      priority                   = 4088
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "0.0.0.0/0"
    },
    {
      name                       = "Deny-Inbound-Internet"
      priority                   = 4095
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny-All-Other-Outbound"
      priority                   = 4096
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  security_rules_to_use = length(var.security_rules) > 0 ? var.security_rules : local.default_security_rules
}
