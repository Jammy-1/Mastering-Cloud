output "host_pool_id" { value = azurerm_virtual_desktop_host_pool.this.id}
output "vmss_id" {value       = azurerm_windows_virtual_machine_scale_set.avd_vmss.id }

output "registration_token" {
  value       = azurerm_virtual_desktop_host_pool_registration_info.this.token 
  sensitive   = true
}

