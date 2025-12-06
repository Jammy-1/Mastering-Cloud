# VNet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = var.tags
}

# VM Subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vm_subnet_cidr]

  depends_on = [azurerm_virtual_network.vnet]
}

# Subnet Gateway
resource "azurerm_subnet" "gateway_subnet" {
  name                 = var.gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.gateway_subnet_cidr]

  depends_on = [azurerm_virtual_network.vnet]
}

# Private Endpoint Subnet
resource "azurerm_subnet" "private_endpoint_subnet" {
  name                 = var.private_endpoint_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_endpoint_subnet_cidr]

  private_link_service_network_policies_enabled = false


  depends_on = [azurerm_virtual_network.vnet]
}

# Attach Subnet
resource "azurerm_subnet_network_security_group_association" "vm_subnet_nsg" {
  count                     = var.attach_nsg_to_vm_subnet ? 1 : 0
  subnet_id                 = azurerm_subnet.vm_subnet.id
  network_security_group_id = var.nsg_id
}