output "aadds_id" { value = azurerm_active_directory_domain_service.aadds.id }
output "aadds_name" { value = azurerm_active_directory_domain_service.aadds.name }
output "dc_admin_group_id" { value = azuread_group.dc_admins.object_id }
