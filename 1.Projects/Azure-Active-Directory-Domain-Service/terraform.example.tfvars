# General Settings
resource_group = "RG-AAD-MST"
location       = "UKWEST"

# Networking
vnet_name      = "VNET-AAD-MST"
address_spaces = ["10.0.0.0/16"]
nsg_name       = "NSG-AAD-MST"
dns_servers    = ["10.0.0.4", "10.0.0.5"]

subnets = [
  {
    name             = "subnet-01-AADS"
    address_prefixes = ["10.0.1.0/24"]
    attach_nsg       = true
  },
  {
    name             = "subnet-02"
    address_prefixes = ["10.0.2.0/24"]
    attach_nsg       = true
  }
]

# Azure AD Domain Services
aadds_name            = "AADS Project"
domain_name           = "example-domain.co.uk"
sku                   = "Enterprise"
filtered_sync_enabled = false

dc_admin_upn          = "dcadmin@example-domain.co.uk"
dc_admin_display_name = "Example-Username"
dc_admin_password     = "example-password"

additional_recipients = ["alerts@example-domain.co.uk"]
notify_dc_admins      = true
notify_global_admins  = true

sync_kerberos_passwords = true
sync_ntlm_passwords     = true
sync_on_prem_passwords  = true

# Network Security Rules
security_rules = [
  {
    name                       = "Allow-LDAP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-LDAPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "636"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-Kerberos"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-DC-to-DC"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "135-139"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-DNS"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-DC-Outbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-DNS-Outbound"
    priority                   = 210
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "53"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
