output "vm_id" {value = azurerm_linux_virtual_machine.vm.id }
output "vm_private_ip" { value = azurerm_network_interface.vm_nic.ip_configuration[0].private_ip_address }
output "identity_id" { value = azurerm_user_assigned_identity.vm_identity.id }
