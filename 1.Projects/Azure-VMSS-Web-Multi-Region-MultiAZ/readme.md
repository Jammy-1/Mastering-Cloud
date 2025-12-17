# Azure-VMSS-Web-Multi-Region-MultiAZ

## Overview

- Terraform project provisions a highly available static website on Microsoft Azure.
- It automatically deploys a scalable, fault-tolerant web infrastructure that serves content directly from a public GitHub repository.
- Fully modular Terraform design separating networking, compute and load balancing components.
- Designed to be reusable and cost effective - supports rapid deployment across regions, zones and subscriptions.
- Multi-region deployment configuration using Azure paired regions for increased resilience and disaster recovery.
- Virtual Machine Scale Sets are distributed across availability zones where supported, providing zone-level fault tolerance.
- Website updates are deployed automatically through GitHub Actions on each push to the main branch. Allowing site updates without redeploying infrastructure.
- Configuration also ensures each Linux VM is kept up to date with the latest system and package updates during provisioning.

## Features

- Creates a dedicated Azure Resource Group to logically isolate all deployed resources.
- Deploys Azure Virtual Networks and subnets per region to support secure and scalable networking.
- Implements an Azure Load Balancer with a public frontend IP and backend pool for high availability and traffic distribution.
- Provisions Azure Virtual Machine Scale Sets (VMSS) across one or more regions for horizontal scalability.
- Distributes VM instances across Availability Zones where supported to increase fault tolerance.
- Automatically installs and configures Apache and Git on each Linux VM during initial provisioning.
- Clones static website content from a public GitHub repository during VM bootstrap using cloud-init.
- Keeps all VM instances up to date by applying system and package updates at provisioning time.
- Separates infrastructure deployment from application updates to avoid unnecessary VM or scale set redeployments.
- Uses GitHub Actions to automatically deploy updated website content to all running VMSS instances on each push to the main branch.
- Executes updates using Azure-native VMSS Run Command, eliminating the need for SSH access or public VM IPs.
- Supports dynamic discovery of VM Scale Sets within a resource group, enabling updates across multiple regions without manual configuration.
- Designed to scale to large numbers of VM Scale Sets without requiring additional GitHub secrets or Terraform state access.
- Outputs key deployment details including resource group name, VMSS IDs, load balancer backend pool IDs and public IP addresses.

## Continuous Deployment – Static Site Updates

- Website content is deployed initially during VM provisioning using cloud-init.
- Subsequent website updates are handled independently of infrastructure using GitHub Actions.
- When changes are pushed to the main branch—specifically within the Static Site directory—the website is automatically updated across all VM Scale Set instances.
- No VM redeployment, scaling event, or Terraform apply is required to update website content.
- Updates are executed using Azure VMSS Run Command, which securely runs update scripts on all instances without requiring public IP access or SSH.

## This approach cleanly separates:

- Infrastructure lifecycle (Terraform)
- Application/content lifecycle (GitHub Actions)

## Infrastructure Overview:

```
Azure-VMSS-Web-Multi-Region-MultiAZ
└── Resource Group
    ├── Network Security Groups
    │   └── Inbound Rules
    │       ├── Allow HTTP
    │       └── Allow SSH
    │
    ├── Virtual Networks
    │   ├── VNet (Primary Region)
    │   │   └── Subnet
    │   │       └── NSG Association
    │   └── VNet (Paired Region)
    │       └── Subnet
    │           └── NSG Association
    │
    ├── Load Balancers
    │   ├── Public IP
    │   │   └── Azure Load Balancer (Primary Region)
    │   │       └── Backend Pool → VMSS (Primary)
    │   └── Public IP
    │       └── Azure Load Balancer (Paired Region)
    │           └── Backend Pool → VMSS (Paired)
    │
    ├── Virtual Machine Scale Sets
    │   ├── VMSS – Primary Region
    │   │   ├── Availability Zone 1 VM(s)
    │   │   ├── Availability Zone 2 VM(s)
    │   │   └── Availability Zone 3 VM(s)
    │   │
    │   └── VMSS – Paired Region
    │       ├── Availability Zone 1 VM(s)
    │       ├── Availability Zone 2 VM(s)
    │       └── Availability Zone 3 VM(s)
    │
    ├── Automation & CI/CD
    │   ├── GitHub Actions
    │   │   ├── Trigger: Push to main branch
    │   │   ├── Azure authentication (OIDC / Service Principal)
    │   │   ├── Dynamic VMSS discovery (per Resource Group)
    │   │   └── az vmss run-command invoke
    │   │       └── Pulls latest static site content from GitHub
    │   │
    │   └── Update Script (update_site.sh)
    │       ├── Git fetch & reset to latest commit
    │       ├── Copies static site files
    │       ├── Applies permissions
    │       └── Restarts Apache
    │
    └── Static Website Content
        ├── Stored in GitHub Repository
        ├── Served directly by Apache
        └── Automatically updated on every push
```

## Details:

- Load Balancer distributes web traffic evenly across all VM instances.
- Each VM runs Apache and serves content from the GitHub repository.
- When a change is pushed to the GitHub repository, a GitHub Action automatically deploys the latest version of the site to all running VMs.
- VM Scale Set ensures scalability and high availability across multiple zones.

## Automated Website Update Flow:

- Terraform provisions the VMSS and installs Apache and Git using cloud-init.
- Initial website content is cloned from GitHub during VM creation.
- GitHub Actions workflow is triggered on every push to the main branch.

## The Workflow:

- Authenticates to Azure using a Service Principal.
- Dynamically discovers all VM Scale Sets in the target Resource Group.
- Executes a shell script on each VMSS using az vmss run-command invoke.

# Each VM:

- Pulls the latest version of the repository.
- Copies updated static site files into the Apache web root.
- Restarts Apache to serve the new content.

## Deployment Instructions

### 1. Clone this repository:

```powershell
git clone https://github.com/Jammy-1/Mastering-Cloud
```

```powershell
cd Mastering-Cloud/1.Projects/Azure-VMSS-Web-Multi-Region-MultiAZ/
```

### 2. Configure Terraform variables:

- Rename terraform.tfvars.example to terraform.tfvars and update with your desired values:

```
resource_group_name = "rg-static-website"
location = "UK South"
github_repo = "https://github.com/your-org/your-repo"
github_branch = "main"
vm_admin_username = "azureuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"
instance_count = 2
vm_size = "Standard_B2s"
```

- Only public repositories are supported for this configuration.

### 3. Initialize Terraform:

```powershell
terraform init
```

### 4. Preview the deployment plan:

```powershell
terraform plan
```

### 5. Deploy the infrastructure:

```powershell
terraform apply
```

### 6. Access your website:

```powershell
terraform output public_ip
```

### Open http://<public_ip> in your browser to view the site.

Jammy-1 Azure-VMSS-Web-Multi-Region-MultiAZ
