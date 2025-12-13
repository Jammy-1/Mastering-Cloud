# Key Vault
resource "azurerm_key_vault" "kv" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.key_vault_sku
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection
  public_network_access_enabled = var.public_network_access_enabled
  rbac_authorization_enabled    = var.rbac_authorization_enabled 

  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]

    key_permissions = [
      "Create", "Get", "List", "Update", "Delete", "WrapKey", "UnwrapKey", "Encrypt", "Decrypt", "Sign", "Verify"
    ]

    certificate_permissions = [
      "Get", "List", "Create", "Delete"
    ]
  }

  tags = var.tags
}

# Give Storage Managed Identity rights to the CMK
resource "azurerm_key_vault_access_policy" "storage_identity_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.storage_identity_principal_id 

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey"
  ]
}

# Access Tennant ID
data "azurerm_client_config" "current" {}

# Store VPN Shared Key
resource "azurerm_key_vault_secret" "vpn_shared_key" {
  name         = var.key_vault_secret_vpn_shared_key_name
  value        = var.vpn_shared_key
  key_vault_id = azurerm_key_vault.kv.id
}

# VM Disk Key
resource "azurerm_key_vault_key" "vm_disk_key" {
  name         = var.key_vault_secret_vm_disk_key
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "wrapKey", "unwrapKey"]
}

# Storage Account Key
resource "azurerm_key_vault_key" "storage_cmk" {
  name         = "storage-cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["wrapKey", "unwrapKey", "encrypt", "decrypt"]
}

resource "azurerm_key_vault_secret" "nas_username" {
  name         = "nas-username"
  value        = var.nas_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "nas_password" {
  name         = "nas-password"
  value        = var.nas_password
  key_vault_id = azurerm_key_vault.kv.id
}
