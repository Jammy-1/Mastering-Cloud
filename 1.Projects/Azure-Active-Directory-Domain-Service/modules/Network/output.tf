output "vnet_name" { value = azurerm_virtual_network.vnet-aad.name }
output "vnet_id" { value = azurerm_virtual_network.vnet-aad.id }
output "subnet_ids" { value = { for name, subnet in azurerm_subnet.subnet : name => subnet.id } }
output "subnet_names" { value = [for _, subnet in azurerm_subnet.subnet : subnet.name] }


