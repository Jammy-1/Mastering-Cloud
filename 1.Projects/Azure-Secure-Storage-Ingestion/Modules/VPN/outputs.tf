output "vpn_gateway_public_ip" { value = azurerm_public_ip.vpn_gateway_ip.ip_address }
output "vpn_gateway_id" { value = azurerm_virtual_network_gateway.vpn_gateway.id }
output "vpn_gateway_name" { value = azurerm_virtual_network_gateway.vpn_gateway.name }
output "vpn_connection_id" { value = azurerm_virtual_network_gateway_connection.vpn_connection.id }

output "onprem_gateway_address" { value = azurerm_local_network_gateway.onprem.gateway_address }
output "onprem_address_space" { value = azurerm_local_network_gateway.onprem.address_space }
