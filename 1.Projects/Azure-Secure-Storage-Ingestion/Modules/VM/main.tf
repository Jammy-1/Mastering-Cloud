# Cloud Init Script Data
data "template_file" "cloud_init_data" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
    key_vault_name       = var.key_vault_name
    nas_host             = var.nas_host
    nas_share            = var.nas_share
    storage_account_name = var.storage_account_name
    blob_container_name  = var.blob_container_name
  }
}

# NIC
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm_ip_config"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Managed Identity 
resource "azurerm_user_assigned_identity" "vm_identity" {
  name                = "${var.vm_name}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  tags                = var.tags
}

# VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  computer_name       = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.vm_identity.id]
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(data.template_file.cloud_init_data.rendered)
  
  tags = var.tags
}


