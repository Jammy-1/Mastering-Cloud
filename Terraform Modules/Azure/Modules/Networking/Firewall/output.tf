# Resource Group
output "resource_group" { value = { name = azurerm_resource_group.rg.name, location = azurerm_resource_group.rg.location } }

# Virtual Network
output "virtual_network" { value = { name = azurerm_virtual_network.vnet.name, address_space = azurerm_virtual_network.vnet.address_space } }

# Regular Subnet
output "regular_subnet" {
  value = {
    name   = azurerm_subnet.regular_subnet.name
    prefix = azurerm_subnet.regular_subnet.address_prefixes
    nsg    = azurerm_network_security_group.nsg.name
  }
}

# Firewall Subnet
output "firewall_subnet" { value = { name = azurerm_subnet.firewall_subnet.name, prefix = azurerm_subnet.firewall_subnet.address_prefixes } }

# Firewall Public IP
output "firewall_public_ip" {
  value = {
    name = azurerm_public_ip.fw_ip.name
    id   = azurerm_public_ip.fw_ip.id
    ip   = azurerm_public_ip.fw_ip.ip_address
  }
}

# Firewall
output "firewall" {
  value = {
    name       = azurerm_firewall.firewall.name
    id         = azurerm_firewall.firewall.id
    private_ip = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
    rt         = azurerm_route_table.regular_rt.name
  }
}
# Firewall Network Rules
output "firewall_network_rules" {
  value = [
    for r in azurerm_firewall_network_rule_collection.network_rules : {
      name        = r.name
      priority    = r.priority
      action      = r.action
      sources     = r.rule[0].source_addresses
      destinations= r.rule[0].destination_addresses
      ports       = r.rule[0].destination_ports
      protocols   = r.rule[0].protocols
    }
  ]
}
