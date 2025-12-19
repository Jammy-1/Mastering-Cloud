# Resource Group
resource_group_name = "Terraform-VNet-RG"
location            = "UKSOUTH"

# VNet
vnet_name      = "Terraform-VNet"
address_spaces = ["10.0.0.0/16"]
dns_servers    = ["10.0.0.4", "10.0.0.5"]

# Subnets
subnets = [
  {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  },
  {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
  }
]
