#FXLogix Storage Account
resource "azurerm_storage_account" "fslogix" {
  name                     = var.fslogix_storage_account
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "random_id" "fslogix" {
  byte_length = 3
}

# FXLogix Storage Share
resource "azurerm_storage_share" "fslogix_share" {
  name               = var.fslogix_file_share
  storage_account_id = azurerm_storage_account.fslogix.id
  quota              = var.fslogix_vhdx_size_gb * 2
  depends_on         = [azurerm_storage_account.fslogix]
}

# Grant VMSS Access To Storage account
resource "azurerm_role_assignment" "fslogix_share_contributor" {
  principal_id         = var.vmss_principal_id
  role_definition_name = "Storage File Data SMB Share Contributor"
  scope                = azurerm_storage_account.fslogix.id
}

