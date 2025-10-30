output "network_info" {
  description = "All important information about the VNet and its subnets"
  value = {
    resource_group = {
      name     = azurerm_resource_group.RG-Template-Module.name
      location = azurerm_resource_group.RG-Template-Module.location
    }

    vnet = {
      id            = azurerm_virtual_network.VNet-Template-Module.id
      name          = azurerm_virtual_network.VNet-Template-Module.name
      location      = azurerm_virtual_network.VNet-Template-Module.location
      address_space = azurerm_virtual_network.VNet-Template-Module.address_space
      dns_servers   = azurerm_virtual_network.VNet-Template-Module.dns_servers
    }

    subnets = {
      for s in azurerm_subnet.Subnet-Template-Name : s.name => {
        id              = s.id
        name            = s.name
        address_prefixes = s.address_prefixes
      }
    }

    subnet_count = length(azurerm_subnet.Subnet-Template-Name)
  }
}
