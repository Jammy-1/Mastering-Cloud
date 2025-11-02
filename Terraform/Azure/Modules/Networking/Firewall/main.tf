# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Regular Subnet
resource "azurerm_subnet" "regular_subnet" {
  name                 = var.regular_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.regular_subnet_prefix]
}

# Associate NSG with Regular Subnet
resource "azurerm_subnet_network_security_group_association" "regular_subnet_assoc" {
  subnet_id                 = azurerm_subnet.regular_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Firewall Subnet (no NSG allowed)
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.firewall_subnet_prefix]
}

# Public IP for Firewall
resource "azurerm_public_ip" "fw_ip" {
  name                = var.firewall_public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_ip.id
  }

  depends_on = [
    azurerm_subnet.firewall_subnet,
    azurerm_public_ip.fw_ip
  ]
}

# Route Table for Regular Subnet
resource "azurerm_route_table" "regular_rt" {
  name                = "regular-subnet-rt"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Default route: send all traffic through the Firewall
resource "azurerm_route" "default_fw_route" {
  name                   = "default-to-firewall"
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.regular_rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address

  depends_on = [azurerm_firewall.firewall]
}

# Associate Route Table with Regular Subnet
resource "azurerm_subnet_route_table_association" "regular_subnet_rt_assoc" {
  subnet_id      = azurerm_subnet.regular_subnet.id
  route_table_id = azurerm_route_table.regular_rt.id
}

# Firewall Rule Collections
resource "azurerm_firewall_network_rule_collection" "network_rules" {
  for_each            = { for r in var.firewall_network_rules : r.name => r }
  name                = each.value.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = each.value.priority
  action              = each.value.action

  rule {
    name                  = each.value.name
    source_addresses      = each.value.source_addresses
    destination_addresses = each.value.destination_addresses
    destination_ports     = each.value.destination_ports
    protocols             = each.value.protocols
  }
}

