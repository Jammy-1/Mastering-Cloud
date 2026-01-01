resource "azurerm_windows_virtual_machine_scale_set" "avd_vmss" {
  name                = "${var.vmss_name_prefix}-VMSS"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vmss_sku
  instances           = var.initial_instance_count
  overprovision       = true

  identity {
    type = "SystemAssigned"
  }

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface {
    name    = "avd-nic"
    primary = true

    ip_configuration {
      name      = "avd-ipconfig"
      subnet_id = var.avd_subnet_id
      primary   = true
    }
  }

  source_image_reference {
    publisher = var.vmss_image_publisher
    offer     = var.vmss_image_offer
    sku       = var.vmss_image_sku
    version   = var.vmss_image_version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vmss_os_disk_type
    disk_size_gb         = var.vmss_os_disk_size_gb
  }
}

# AAD 
resource "azurerm_virtual_machine_scale_set_extension" "aad_login" {
  name                         = "AADLoginForWindows"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.avd_vmss.id
  publisher                    = "Microsoft.Azure.ActiveDirectory"
  type                         = "AADLoginForWindows"
  type_handler_version         = "2.2"
  auto_upgrade_minor_version   = true

  settings = "{}"

  protected_settings = jsonencode({
    tenantId = var.aad_tenant_id
    mdm      = var.mdm_enrollment_id
  })

  depends_on = [
  azurerm_windows_virtual_machine_scale_set.avd_vmss
]

}

# AVD Registration
resource "azurerm_virtual_machine_scale_set_extension" "avd_registration" {
  name                         = "AVDRegister"
  virtual_machine_scale_set_id = azurerm_windows_virtual_machine_scale_set.avd_vmss.id
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.10"
  auto_upgrade_minor_version   = true

  settings = jsonencode({
    fileUris = [
      "${path.module}/Scripts/InstallAVDAgent.ps1"
    ]
    commandToExecute = "powershell.exe -ExecutionPolicy Bypass -File InstallAVDAgent.ps1 -RegistrationToken ${azurerm_virtual_desktop_host_pool_registration_info.avd_token.token}"
  })

  depends_on = [
  azurerm_virtual_machine_scale_set_extension.aad_login
]

}
