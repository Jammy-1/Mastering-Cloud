# VNet
resource "azurerm_virtual_network" "vnet-aad" {
  name                = var.vnet_name
  resource_group_name = var.resource_group
  location            = var.location
  address_space       = var.address_spaces
  dns_servers         = var.dns_servers
}
# Subnet
resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet-aad.name
  address_prefixes     = each.value.address_prefixes
}
