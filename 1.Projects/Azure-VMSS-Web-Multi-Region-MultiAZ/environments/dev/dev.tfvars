# General
resource_group_name = "Azure-VMSS-Web-Multi-Region-MultiAZ-Development"
location            = "uksouth"

tags = {
  environment = "Development"
  project     = "Web-Site"
  owner       = "Web-Development"
}

# VMSS Tags
vmss_tags = {
  App  = "vmss-static-site"
  tier = "web"
}

# VNet
vnet_name          = "vnet-static"
vnet_address_space = ["10.0.0.0/16"]
subnet_name        = "snet-web-dev"
subnet_prefix      = "10.0.1.0/24"

public_ip_name = "pub-static-lb"

# VM
vm_admin_username = "azureuser"
vm_size           = "Standard_B2s"
instance_count    = 2

# GitHub Repo
github_repo    = "https://github.com/Jammy-1/Azure-VMSS-Web-Multi-Region-MultiAZ"
github_branch  = "main"
github_private = false
