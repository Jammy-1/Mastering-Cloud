# AAD Admin Group
resource "azuread_group" "dc_admins" {
  display_name     = "AAD DC Administrators"
  security_enabled = true
}

# User
resource "azuread_user" "admin" {
  user_principal_name = var.dc_admin_upn
  display_name        = var.dc_admin_display_name
  password            = var.dc_admin_password
  force_password_change = false
}

resource "azuread_group_member" "admin" {
  group_object_id  = azuread_group.dc_admins.object_id
  member_object_id = azuread_user.admin.object_id
}

# AADS SP
resource "azuread_service_principal" "aadds" {
  client_id = "2565bd9d-da50-47d4-8b85-4c97f669dc36"
}

# AAD Domain Service
resource "azurerm_active_directory_domain_service" "aadds" {
  name                  = var.aadds_name
  location              = var.location
  resource_group_name   = var.resource_group
  domain_name           = var.domain_name
  sku                   = var.sku
  filtered_sync_enabled = var.filtered_sync_enabled

  initial_replica_set {
    subnet_id = var.subnet_id
  }

  notifications {
    additional_recipients = var.additional_recipients
    notify_dc_admins      = var.notify_dc_admins
    notify_global_admins  = var.notify_global_admins
  }

  security {
    sync_kerberos_passwords = var.sync_kerberos_passwords
    sync_ntlm_passwords     = var.sync_ntlm_passwords
    sync_on_prem_passwords  = var.sync_on_prem_passwords
  }

  depends_on = [
    azuread_service_principal.aadds
  ]
}
