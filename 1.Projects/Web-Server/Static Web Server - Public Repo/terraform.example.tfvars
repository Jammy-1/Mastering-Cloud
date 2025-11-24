# Terraform TFVARS Example 

# Project Defaults
resource_group_name = "HA-Static-Web-Server-Public-Repo"
location            = "ukwest"

tags = {
  environment = "prod"
  project     = "static-site-public"
  owner       = "devops-team"
}

# Networking 
vnet_name          = "vnet-static"
vnet_address_space = ["10.0.0.0/16"]
subnet_name        = "snet-web"
subnet_prefix      = "10.0.1.0/24"

# Load Balancer 
public_ip_name = "pip-static-lb"

# Virtual Machine Scale Set
vm_admin_username   = "azureadminuser"
ssh_public_key_path = "C:/.ssh/id_Example.pub"

instance_count = 2
vm_size        = "Standard_B1ms"

# GitHub Repository 
github_repo    = "https://github.com/Jammy-1/Azure-Highly-Available-Static-Website.git"
github_branch  = "main"
github_private = false
