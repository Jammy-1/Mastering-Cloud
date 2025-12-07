output "key_vault_id" { value = azurerm_key_vault.kv.id }
output "key_vault_uri" { value = azurerm_key_vault.kv.vault_uri }
output "vpn_shared_key_secret_id" { value = azurerm_key_vault_secret.vpn_shared_key.id }
output "vpn_shared_key_secret_value" {
  value     = azurerm_key_vault_secret.vpn_shared_key.value
  sensitive = true
}
