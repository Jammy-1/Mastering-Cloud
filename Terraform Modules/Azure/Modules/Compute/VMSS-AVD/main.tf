# Host Pool
resource "azurerm_virtual_desktop_host_pool" "this" {
  name                       = var.host_pool_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  type                       = var.host_pool_type   
  load_balancer_type         = var.load_balancer_type  
  preferred_app_group_type   = "Desktop"
  maximum_sessions_allowed   = 10
  friendly_name              = var.host_pool_name
}

# App Group
resource "azurerm_virtual_desktop_application_group" "desktop" {
  name                 = var.application_group_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  type                 = "Desktop"
  host_pool_id         = azurerm_virtual_desktop_host_pool.this.id
}

#WorkSpace
resource "azurerm_virtual_desktop_workspace" "this" {
  name                 = var.workspace_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  friendly_name        = var.workspace_name
}

# Group Association
resource "azurerm_virtual_desktop_workspace_application_group_association" "assoc" {
  workspace_id         = azurerm_virtual_desktop_workspace.this.id
  application_group_id = azurerm_virtual_desktop_application_group.desktop.id
}

# Host Pool Registration
resource "azurerm_virtual_desktop_host_pool_registration_info" "this" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.this.id
  expiration_date = timeadd(timestamp(), "4h")
}

# NSG Group
resource "azurerm_network_security_group" "this" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

#NSG Rules
resource "azurerm_network_security_rule" "rules" {
  for_each = { for idx, rule in var.security_rules : idx => rule }

  name                        = each.value.name
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name

  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol

  source_port_range          = lookup(each.value, "source_port_range", "*")
  destination_port_range     = lookup(each.value, "destination_port_range", "*")
  source_address_prefix      = lookup(each.value, "source_address_prefix", "*")
  destination_address_prefix = lookup(each.value, "destination_address_prefix", "*")

  depends_on = [azurerm_network_security_group.this]
}


#VNet
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_spaces
}

# Subnet
resource "azurerm_subnet" "this" {
  for_each = { for s in var.subnets : s.name => s }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
}
