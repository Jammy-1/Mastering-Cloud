                                                    Azure Virtual Desktop (AVD) Terraform Deployment

Fully modular Terraform project that deploys an Azure Virtual Desktop environment using VM Scale Sets, FSLogix profile storage, Azure AD join, and a complete virtual network and security configuration.

Overview
- Terraform solution provisions a production-ready Azure Virtual Desktop (AVD) environment using Microsoft Azure best practices.
- The deployment includes a host pool backed by a Virtual Machine Scale Set (VMSS), automated agent installation, Azure Entra & Intune join, FSLogix profile container integration and a fully isolated virtual network with NSG security controls.
- The project is composed of reusable modules for the resource group, virtual network, NSGs, AVD host pool, VMSS and FSLogix.
- All components are fully parameterized using variables allowing flexible customization and clean re-use across environments.

Key Features
- Creates a dedicated Azure resource group
- Builds a complete virtual network with user-defined address spaces and subnets
- Configures NSG rules and attaches them to the AVD subnet

Deploys a full Azure Virtual Desktop environment:
- Host pool
- Application group (Session Desktop)
- Workspace
- Registration token generation

Implements a VM Scale Set for AVD session hosts:
-Azure Entra AD Join
- AAD Login extension
- Intune MDM
- FSLogix 
- AVD Agent + Bootloader
- Automatic scaling settings

Integrates FSLogix profile storage:
- Storage account
- File share creation
- RBAC assignment for VMSS managed identity

Supports custom OS images - Windows 10/11 Enterprise AVD

Infrastructure Layout
The deployment creates the following logical structure:

Resource Group
└── Virtual Network
    └── Subnets
        └── AVD-Subnet (NSG attached)
└── Network Security Group (with custom rules)
└── FSLogix Storage
    └── File Share for VHDX profile containers
└── Azure Virtual Desktop
    ├── Host Pool
    ├── Registration Token
    ├── Application Group (Session Desktop)
    └── Workspace
└── Virtual Machine Scale Set
    ├── Windows 10/11 multi-session image
    ├── Entra ID Join
    ├── AAD Login Extension
    ├── FSLogix configuration
    └── AVD Agent + Bootloader registration

How the Deployment Works

1. Networking
A virtual network and subnets are created using the network module.
NSGs are created separately and then bound to the AVD subnet to restrict traffic to RDP, AVD agent endpoints and ports.

2. AVD Host Pool Stack
The avd module provisions:

- Host pool Pooled
- Session Desktop application group
- Workspace
- Registration token used to enroll session hosts

3. VM Scale Set Session Hosts
 VMSS automatically:
- Uses the configured Windows AVD image
- Joins devices to Entra ID & Intune
- AADLoginForWindows
- Registers itself with the host pool using the token
- Installs the AVD Agent and Boot Loader
- Applies the FSLogix configuration (registry + file share path)



4. FSLogix Profile Storage
Storage account and file share are created for user profiles.
The VMSS system-assigned managed identity receives the necessary permissions to read/write FSLogix VHDX files.

Deployment Instructions
1. Clone the repository

git clone <your-repository-url>
cd <repo-directory>

2. Configure your variables
Rename and edit:

terraform.tfvars.example → terraform.tfvars

Change Values
resource_group_name   = "rg-avd-demo"
location              = "UK West"

vnet_name             = "vnet-avd"
vnet_address_spaces   = ["10.10.0.0/16"]

subnets = {
  AVD-Subnet = "10.10.1.0/24"
}

host_pool_name        = "hp-avd-main"
vmss_name_prefix      = "avdhost"
vmss_sku              = "Standard_D4s_v5"
initial_instance_count = 1
min_instance_count     = 1
max_instance_count     = 5

admin_username        = "avdadmin"
admin_password        = "YourSecurePassword123"

vmss_image_publisher = "MicrosoftWindowsDesktop"
vmss_image_offer     = "windows-11"
vmss_image_sku       = "win11-22h2-avd"
vmss_image_version   = "latest"

aad_tenant_id         = "<tenant-guid>"
mdm_enrollment_id     = "<intune-enrollment-id>"
fslogix_storage_account = "fslogixavd001"
fslogix_file_share      = "profiles"

3. Initialize Terraform

terraform init

4. Validate and review the plan

terraform plan

5. Deploy

terraform apply

6. Connect to Azure Virtual Desktop
Assign users to the AVD application group, then log in through:

- Windows AVD Client
- macOS client

Web client: https://windows.cloud.microsoft

Outputs
After deployment completes Terraform provides:

- host_pool_id – ID of the created host pool
- vmss_id – Virtual Machine Scale Set ID
- workspace_name – Workspace users connect through
- fslogix_file_share_url – Path used for profile containers
- subnet_ids – IDs of all deployed subnets


