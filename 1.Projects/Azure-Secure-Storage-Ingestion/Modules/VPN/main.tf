# Public IP
resource "azurerm_public_ip" "vpn_gateway_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku

  tags = var.tags
}

# VNet Gateway
resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.network_vpn_gateway_type
  vpn_type            = var.vpn_gateway_type
  enable_bgp          = false
  active_active       = false
  sku                 = var.vpn_sku

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.vpn_gateway_ip.id
    subnet_id            = var.gateway_subnet
  }
  tags = var.tags
}


# On Prem Gateway 
resource "azurerm_local_network_gateway" "onprem" {
  name                = var.on_prem_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.on_prem_public_ip
  address_space       = [var.on_prem_address_space]

  tags = var.tags
}


# Site To Site Connection
resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                       = var.vpn_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id
  type                       = var.vpn_type
  shared_key                 = var.vpn_shared_key
  enable_bgp                 = false
  
  tags = var.tags
}

