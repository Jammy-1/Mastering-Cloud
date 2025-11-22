output "host_pool_id" {
  value = azurerm_virtual_desktop_host_pool.this.id
}

output "registration_token" {
  value       = azurerm_virtual_desktop_host_pool_registration_info.this.token
  description = "AVD registration token for session hosts"
  sensitive   = true
}

output "vmss_id" {
  description = "The ID of the VMSS"
  value       = azurerm_windows_virtual_machine_scale_set.avd_vmss.id
}
