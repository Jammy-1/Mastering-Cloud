# VMSS
resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "vmss-web-${var.location}"
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  sku                 = var.vm_size
  instances           = var.instance_count
  admin_username      = var.vm_admin_username
  tags                = var.tags

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-22_04-lts"
    sku       = "server"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = var.vm_admin_ssh_key
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "ipconfig"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.lb_backend_address_pool_id]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Script
  custom_data = base64encode(
    templatefile("${path.module}/../Scripts/cloud_init.yml.tpl", {
      GITHUB_REPO   = var.github_repo
      GITHUB_BRANCH = var.github_branch
    })
  )

  upgrade_mode = "Automatic"
}
