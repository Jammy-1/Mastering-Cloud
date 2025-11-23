# Azure Location & Resource Group
location               = "uksouth"
resource_group_name    = "rg-avd-prod"

# AVD Host Pool & Application 
host_pool_name         = "avd-hostpool-01"
host_pool_type         = "Pooled"
load_balancer_type     = "BreadthFirst"
application_group_name = "avd-appgroup-desktop"
workspace_name         = "avd-workspace-01"

# VMSS Scaling
initial_instance_count = 2
min_instance_count     = 2
max_instance_count     = 10

# VM Administrator Credentials
admin_username         = "azureadmin"
admin_password         = "YOUR-STRONG-PASSWORD"

# Subnet ID for AVD VMSS
avd_subnet_id          = "/subscriptions/<subscription_id>/resourceGroups/rg-avd/providers/Microsoft.Network/virtualNetworks/avd-vnet/subnets/AVD-Subnet"

# Networking
vnet_name              = "AVD-VNet-VMSS"
vnet_address_spaces    = ["10.0.0.0/16"]
nsg_name               = "NSG"

# NSG Rules
security_rules = [
  {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-ALB"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-SMB-Outbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTPS-Outbound"
    priority                   = 201
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# Subnet
subnets = [
  {
    name             = "AVD-Subnet"
    address_prefixes = ["10.0.10.0/24"]
    attach_nsg       = true
  }
]
