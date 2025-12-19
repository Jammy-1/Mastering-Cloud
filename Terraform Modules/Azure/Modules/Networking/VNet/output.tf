# RG
output "resource_group" {
  value = {
    name     = azurerm_resource_group.RG-Template-Module.name
    location = azurerm_resource_group.RG-Template-Module.location
  }
}

# Vnet
output "virtual_network" {
  value = {
    id            = azurerm_virtual_network.VNet-Template-Module.id
    name          = azurerm_virtual_network.VNet-Template-Module.name
    location      = azurerm_virtual_network.VNet-Template-Module.location
    address_space = azurerm_virtual_network.VNet-Template-Module.address_space
    dns_servers   = azurerm_virtual_network.VNet-Template-Module.dns_servers
  }
}

# Subnets
output "subnets" {
  value = {
    for s in azurerm_subnet.Subnet-Template-Name : s.name => {
      id               = s.id
      name             = s.name
      address_prefixes = s.address_prefixes
    }
  }
}

# Subnet Count
output "subnet_count" { value = length(azurerm_subnet.Subnet-Template-Name) }
