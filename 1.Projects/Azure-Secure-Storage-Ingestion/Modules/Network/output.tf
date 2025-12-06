output "vnet_id" { value = azurerm_virtual_network.vnet.id }
output "vm_subnet_id" { value = azurerm_subnet.vm_subnet.id }
output "private_endpoint_subnet_id" { value = azurerm_subnet.private_endpoint_subnet.id }
output "gateway_subnet_id" { value = azurerm_subnet.gateway_subnet.id }
