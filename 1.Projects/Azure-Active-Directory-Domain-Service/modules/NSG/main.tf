# NSG Group
resource "azurerm_network_security_group" "NSG" {
  name                = var.nsg_name
  resource_group_name = var.resource_group
  location            = var.location
}

#NSG Rules
resource "azurerm_network_security_rule" "rules" {
  for_each = { for idx, rule in var.security_rules : idx => rule }

  name                        = each.value.name
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.NSG.name

  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol

  source_port_range          = lookup(each.value, "source_port_range", "*")
  destination_port_range     = lookup(each.value, "destination_port_range", "*")
  source_address_prefix      = lookup(each.value, "source_address_prefix", "*")
  destination_address_prefix = lookup(each.value, "destination_address_prefix", "*")

  depends_on = [azurerm_network_security_group.NSG]
}