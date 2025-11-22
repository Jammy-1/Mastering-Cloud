# Resource Group
resource "azurerm_resource_group" "RG-Template_Module" {
  name     = var.resource_group_name
  location = var.location
}

# NSG
resource "azurerm_network_security_group" "NetSecurityGroup_Template" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# NSG Rules
resource "azurerm_network_security_rule" "SecurityGroup_Template" {
  for_each = var.security_rules

  name                        = each.value.name
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.NetSecurityGroup_Template.name

  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol

  source_port_range          = lookup(each.value, "source_port_range", "*")
  destination_port_range     = lookup(each.value, "destination_port_range", "*")
  source_address_prefix      = lookup(each.value, "source_address_prefix", "*")
  destination_address_prefix = lookup(each.value, "destination_address_prefix", "*")
}
