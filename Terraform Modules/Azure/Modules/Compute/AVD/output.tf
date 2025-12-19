output "host_pool_id"       { value = azurerm_virtual_desktop_host_pool.this.id }
output "host_pool_name" { value = azurerm_virtual_desktop_host_pool.this.name }
output "host_pool_type" { value = azurerm_virtual_desktop_host_pool.this.type }
output "host_pool_load_balancer_type" { value = azurerm_virtual_desktop_host_pool.this.load_balancer_type }
output "avd_registration_token" {
  value     = azurerm_virtual_desktop_host_pool_registration_info.avd_token.token
  sensitive = true
}