output "identity_principal_id" { value = azurerm_user_assigned_identity.storage_identity.principal_id }

output "storage_account_id" { value = azurerm_storage_account.storage.id }
output "storage_account_name" { value = azurerm_storage_account.storage.name }

output "blob_container_name" { value = azurerm_storage_container.backup_container.name }
output "storage_private_endpoint_id" { value = azurerm_private_endpoint.storage_pe.id }
output "storage_private_dns_zone_id" { value = azurerm_private_dns_zone.storage_dns.id }

output "storage_account_key" {
  value     = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}