output "resource_group_name" { value = var.resource_group_name }
output "nsg_info" {
  description = "NSG Details"
  value = {
    id             = azurerm_network_security_group.NetSecurityGroup_Template.id
    name           = azurerm_network_security_group.NetSecurityGroup_Template.name
    location       = azurerm_network_security_group.NetSecurityGroup_Template.location
    security_rules = azurerm_network_security_group.NetSecurityGroup_Template
    tags           = azurerm_network_security_group.NetSecurityGroup_Template.tags
  }
}

output "security_rules_applied" {
  value = {
    for k, r in azurerm_network_security_rule.SecurityGroup_Template : k => {
      name                       = r.name
      priority                   = r.priority
      direction                  = r.direction
      access                     = r.access
      protocol                   = r.protocol
      source_port_range          = r.source_port_range
      destination_port_range     = r.destination_port_range
      source_address_prefix      = r.source_address_prefix
      destination_address_prefix = r.destination_address_prefix
    }
  }
}
