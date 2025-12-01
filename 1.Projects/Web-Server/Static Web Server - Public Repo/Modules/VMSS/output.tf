output "vmss_id" { value = azurerm_linux_virtual_machine_scale_set.this.id }
output "vmss_name" { value = azurerm_linux_virtual_machine_scale_set.this.name }
output "vmss_zones" { value = azurerm_linux_virtual_machine_scale_set.this.zones }

output "vmss_per_region" {
  value = {
    name  = azurerm_linux_virtual_machine_scale_set.this.name
    zones = azurerm_linux_virtual_machine_scale_set.this.zones
    id    = azurerm_linux_virtual_machine_scale_set.this.id
  }
}
