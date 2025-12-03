                                                Azure Highly Available Static Website Terraform Setup

Overview
-Terraform project provisions a highly available static website on Microsoft Azure.
-It automatically deploys a scalable, fault-tolerant web infrastructure that serves content directly from a public GitHub repository.
-Fully modular Terraform design separating networking, compute, and load balancing components.
-Website updates are deployed automatically through GitHub Actions on each push to the main branch.
-Configuration also ensures each Linux VM is kept up to date with the latest system and package updates during provisioning.

Features
-Creates a dedicated Azure Resource Group
-Deploys a Load Balancer with frontend IP and backend pool for high availability
-Creates a Virtual Machine Scale Set (VMSS) with multiple web instances
-Installs Apache and Git automatically on each VM
-Clones website content directly from a public GitHub repository
-Automatically applies system and package updates during VM provisioning
-GitHub Actions triggers new deployments automatically when the repository is updated
-Outputs key deployment details such as VMSS ID, Load Balancer backend pool ID and public IP address

Infrastructure Overview
-Deployed Azure infrastructure is structured:

Resource Group: rg-static-website
└── Load Balancer: web-lb
    ├── Frontend IP: pip-static-lb
    └── Backend Pool: backend-pool
└── VM Scale Set: web-vmss (2 instances)
    ├── Apache installed and running
    ├── System and package updates applied
    └── Website cloned from GitHub repository


Details:
-Load Balancer distributes web traffic evenly across all VM instances.
-Each VM runs Apache and serves content from the GitHub repository.
-When a change is pushed to the GitHub repository, a GitHub Action automatically deploys the latest version of the site to all running VMs.
-VM Scale Set ensures scalability and high availability across multiple zones.

Deployment Instructions

Clone this repository:
git clone <your-repo-url>
cd <repo-directory>


Configure Terraform variables:
Rename terraform.tfvars.example to terraform.tfvars and update with your desired values:

resource_group_name = "rg-static-website"
location            = "UK South"
github_repo         = "https://github.com/your-org/your-repo"
github_branch       = "main"
vm_admin_username   = "azureuser"
ssh_public_key_path = "~/.ssh/id_rsa.pub"
instance_count      = 2
vm_size             = "Standard_B2s"


Only public repositories are supported for this configuration.

Initialize Terraform:
terraform init


Preview the deployment plan:
terraform plan


Deploy the infrastructure:
terraform apply

Access your website:
terraform output public_ip


Open http://<public_ip> in your browser to view the site.

Outputs
-resource_group_name – Name of the deployed Resource Group
-vmss_id – The ID of the Virtual Machine Scale Set
-backend_address_pool_id – The Load Balancer backend pool ID
-public_ip – The public IP address of the Load Balancer

© Jammy-1 Azure Static Website Terraform