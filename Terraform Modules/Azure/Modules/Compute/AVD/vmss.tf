resource "azurerm_windows_virtual_machine_scale_set" "avd_vmss" {
  name                = "${substr(var.host_pool_name, 0, 3)}-vmss"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_D2s_v3"
  instances           = var.initial_instance_count
  overprovision       = true

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
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "20h2-evd"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 127
  }

  extension {
    name                 = "FSLogixConfiguration"
    publisher            = "Microsoft.Compute"
    type                 = "CustomScriptExtension"
    type_handler_version = "1.10"

    settings = jsonencode({
      commandToExecute = format(
        "powershell -ExecutionPolicy Bypass -Command \"New-Item -Path 'HKLM:\\SOFTWARE\\FSLogix' -Force; `nSet-ItemProperty -Path 'HKLM:\\SOFTWARE\\FSLogix' -Name 'VHDLocations' -Value '\\\\%s.file.core.windows.net\\%s'; `nSet-ItemProperty -Path 'HKLM:\\SOFTWARE\\FSLogix' -Name 'Enabled' -Value 1; `nSet-ItemProperty -Path 'HKLM:\\SOFTWARE\\FSLogix' -Name 'MaxVHDSizeInMB' -Value %d;\"",
        var.fslogix_storage_account,
        var.fslogix_file_share,
        var.fslogix_vhdx_size_gb * 1024
      )
    })
  }
}
