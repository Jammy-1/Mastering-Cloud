                                    Azure Active Directory Domain Services (AADDS) Terraform Project
Overview
- Terraform project provisions an Azure Active Directory Domain Services (AADDS) instance in a dedicated virtual network.
- It automates deployment of a managed domain with replication, security synchronization and DC admin configuration.
- Fully modular design separates resource group, networking, NSG and AADDS modules for easier management and reuse.
- Enables seamless domain join for Azure VMs within the same subnet without requiring on-premises Active Directory.
- Supports notifications, secure LDAP and password synchronization for enterprise-ready domain services.

Features
- Creates a dedicated Azure Resource Group for AADDS.
- Deploys a Virtual Network and subnets for domain services.
- Configures Network Security Groups with rules required for domain join and authentication.
- Creates a Domain Services managed domain with configurable domain name and SKU.
- Sets up a DC administrator user and security groups for domain management.
- Supports password synchronization options: Kerberos, NTLM and on-prem password sync.
- Configures notifications for domain service events and admin alerts.
- Outputs key deployment information such as managed domain name, subnet ID and DNS servers.

Infrastructure Overview
Azure infrastructure is structured as follows:

Resource Group: rg-aadds
└── Virtual Network: vnet-aadds
    ├── Subnet: subnet-AADS (AADDS-enabled)
    └── Network Security Group: nsg-aadds
        └── Security rules allowing required ports for LDAP, Kerberos, DNS and SMB
└── Azure AD Domain Services: example-aadds
    ├── Domain Name: example.co.uk
    ├── SKU: Enterprise
    ├── DC Administrator: dcadmin@example.co.uk
    ├── Notifications: Alerts to specified email addresses
    └── Password synchronization enabled for Kerberos, NTLM and on-prem

Details
- VMs in the same subnet can join the AADDS domain automatically.
- The managed domain handles replication and domain controller availability removing the need for self-managed DCs in Azure.
- Notifications and security sync options ensure enterprise compliance and simplified domain management.
- DNS servers for the VNet are configured to use the AADDS managed domain enabling name resolution.

Deployment Instructions

1.Clone the repository

git clone <your-repo-url>
cd <repo-directory>

2. Configure Terraform variables

Rename terraform.tfvars.example to terraform.tfvars and update only the values below for your environment:

# AADDS Settings
resource_group_name        = "rg-aadds"
location                   = "UK West"
aadds_name                 = "example-aadds"
domain_name                = "example.co.uk"
sku                        = "Enterprise"
filtered_sync_enabled      = false
subnet_id                  = module.network.subnet_ids["subnet-AADS"]

# DC Admin Account
dc_admin_upn               = "dcadmin@example.co.uk"
dc_admin_display_name      = "AAD DS Admin"
dc_admin_password          = "Example-Password"

# Notifications
additional_recipients      = ["alerts@example.co.uk]
notify_dc_admins           = true
notify_global_admins       = true

# Password Sync 
sync_kerberos_passwords    = true
sync_ntlm_passwords        = true
sync_on_prem_passwords     = true

3. Initialize Terraform

terraform init

4. Preview the deployment plan

terraform plan

5. Deploy the infrastructure

terraform apply

Accessing the Managed Domain

- Configure your Azure VMs in the same subnet using the custom DNS
- This ensures the VMs can resolve the AADDS domain and join it successfully.

Join the VM to the domain using standard Windows domain join procedures:

Domain: example.co.uk
Username: dcadmin@exampleco.uk
Password: <your password from TFVARS>
DNS Server(s): Custom DNS IP