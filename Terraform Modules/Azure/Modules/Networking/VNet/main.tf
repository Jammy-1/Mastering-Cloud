# Resource Group
resource "azurerm_resource_group" "RG-Template-Module" {
  name     = var.resource_group_name
  location = var.location
}
# VNet
resource "azurerm_virtual_network" "VNet-Template-Module" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_spaces
  dns_servers         = var.dns_servers
}

# Subnet
resource "azurerm_subnet" "Subnet-Template-Name" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.VNet-Template-Module.name
  address_prefixes     = each.value.address_prefixes
}
