output "all_resources" {
  description = "All important resources info"
  value = {
    resource_group = {
      name     = azurerm_resource_group.rg.name
      location = azurerm_resource_group.rg.location
    }
    virtual_network = {
      name          = azurerm_virtual_network.vnet.name
      address_space = azurerm_virtual_network.vnet.address_space
    }
    regular_subnet = {
      name       = azurerm_subnet.regular_subnet.name
      prefix     = azurerm_subnet.regular_subnet.address_prefixes
      nsg        = azurerm_network_security_group.nsg.name
    }
    firewall_subnet = {
      name   = azurerm_subnet.firewall_subnet.name
      prefix = azurerm_subnet.firewall_subnet.address_prefixes
    }
    public_ip = {
      name   = azurerm_public_ip.fw_ip.name
      id     = azurerm_public_ip.fw_ip.id
      ip     = azurerm_public_ip.fw_ip.ip_address
    }
    firewall = {
      name          = azurerm_firewall.firewall.name
      id            = azurerm_firewall.firewall.id
      private_ip    = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
      routing_table = azurerm_route_table.regular_rt.name
    }
    firewall_rules = [
      for r in azurerm_firewall_network_rule_collection.network_rules :
      {
        name                  = r.name
        priority              = r.priority
        action                = r.action
        source_addresses      = [for rule in r.rule : rule.source_addresses][0]
        destination_addresses = [for rule in r.rule : rule.destination_addresses][0]
        destination_ports     = [for rule in r.rule : rule.destination_ports][0]
        protocols             = [for rule in r.rule : rule.protocols][0]
      }
    ]
  }
}
