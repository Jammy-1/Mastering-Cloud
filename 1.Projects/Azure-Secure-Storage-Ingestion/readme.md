### Azure-NAS-Secure-Ingestion — Terraform Project

## Overview:

Terraform project deploys a private, low-cost and secure Azure ingestion pipeline that transfers data from an on-premises NAS into Azure Blob Storage (Archive Tier) with no user intervention or public exposure.

- End-to-end encryption
- No public access anywhere
- Cheapest possible Azure hybrid setup
- VM runs on a schedule with logging and monitoring
- Lifecycle policies reduce long-term storage cost
- Perfect for long-term retention and backup ingestion

## Design:

- Site-to-site VPN for encrypted connectivity
- Private Linux VM to read NAS files and upload via AzCopy
- NSG communication with only on-prem systems, Azure platform services and Storage Private Endpoints - eliminating any direct internet exposure
- Storage Account with Private Endpoint
- Lifecycle policies to push data to the Archive tier automatically
- Fully Infrastructure as Code using modular Terraform resources
- No public IPs on compute or storage
- No PC required — the process runs entirely in Azure

This architecture prioritises security, cost efficiency and automation - making it ideal for long-term archival of large data volumes.

## Features

- Creates all required Azure Resource Groups
- Builds a secured Virtual Network with:
- VM subnet
- VPN Gateway subnet
- Private Endpoint subnet
- Deploys a Site-to-Site VPN Gateway for encrypted connectivity
- Configures a Local Network Gateway for on-premises networks
- Establishes a fully encrypted IPsec tunnel
- Deploys a B1s Linux VM with no public IP
- Automated upload process with monitoring and logging
- Mounts the NAS share automatically via VPN
- Uploads data to Blob Storage using AzCopy
- Storage account secured with:

  - Private Endpoint
  - Customer Managed Key (CMK) in Key Vault
  - Blocked public access

- Lifecycle management moves data into Archive tier for lowest cost
- VM uses Managed Identity- No keys stored
- Modular Terraform design for clean structure and reusability
- Outputs provide key identifiers and private endpoints

## Infrastructure Overview

```
Modules/
├── Key-Vault
├── Network
├── NSG
├── Resource-Groups
├── Storage
├── VM
└── VPN

Azure Resource Groups
├── rg-network
│ ├── Network
│ │ ├── vm-subnet
│ │ ├── gateway-subnet
│ │ └── private-endpoint-subnet
│ │
│ ├── VPN
│ │ ├── Public IP
│ │ ├── Virtual Network Gateway
│ │ ├── Local Network Gateway
│ │ └── VPN Connection
│ │
│ └── Network Security Groups
│ ├── vm-subnet
│ ├── private-endpoint-subnet
│ └── Security Rules
│
├── rg-storage
│ ├── Storage Account
│ │ ├── Blob Container
│ │ ├── Private Endpoint
│ │ └── Lifecycle Policy → Moves data to Archive Tier
│ │
│ └── Customer-Managed Key (Key Vault)
│
├── rg-security
│ ├── Key Vault
│ │ ├── VPN Shared Key
│ │ ├── Storage CMK Key
│ │ └── VM Disk Encryption Keys
│ │
│ └── Access Policies
│
└── rg-compute
└── VM
├── Size: B1s (low cost)
├── No Public IP
├── Managed Identity
│
├── NAS Mount
│ └── Mounts //NAS/archive
│
├── AzCopy Automation
│ └── Uploads NAS files → Blob Storage
│
└── Shutdown automation
```

## Key Details:

- VPN Gateway creates an encrypted tunnel to on-prem router/firewall
- Private Endpoint ensures storage traffic never touches the public internet
- NSG security rules blocks all internet egress and inbound access allowing only VPN traffic, DNS, NTP and required storage/private-endpoint communication
- VM connects to NAS file share, reads data then uploads via AzCopy
- Lifecycle rules automatically push data to Archive tier after X days
- Disk + storage encryption provided by Key Vault CMK.

## Automated Upload Execution & Scheduling

- Upload process is fully automated using cloud-init and systemd
- Upload job is scheduled to run daily between 18:00 and 06:00 using a systemd timer
- A hard execution limit of 12 hours ensures predictable runtime and cost control
- Upload process terminates cleanly if the time window is exceeded
- Designed for overnight, low-impact data ingestion windows

## Logging & Monitoring

- Upload process logs execution, progress and completion status to the VM
- Logs include:
  - Start and end timestamps
  - File count and data volume
  - Hourly progress updates
  - Success or timeout status
- Log output is written in a format suitable for Azure Monitor and Log Analytics ingestion

## Project Architecture Considerations

Designed to provide a cost-effective, fully private and security-driven file ingestion pipeline from NAS → Azure Storage
Prioritizes network isolation, zero public exposure and explicit allow-only network paths
Upload execution is time bound (maximum 12 hours) to control cost, limit resource usage and ensure predictable operational behaviour

## VPN Gateway

- Cheapest secure hybrid connectivity option - Cheaper than ExpressRoute
- IPsec encryption end-to-end
- Works with almost any on-prem firewall/router

## Small B1s Linux VM

- Lowest cost compute
- Sufficient for file mounting + AzCopy
- No public IP → significantly reduces attack surface
- Managed Identity → no credentials stored on VM

## Blob Storage + Archive Tier

- Cheapest storage option in Azure
- Perfect for long-term archive
- Lifecycle rules automate transitions

## Network

- Ensures storage access remains private
- Prevents accidental public exposure
- Enforce Zero Trust network design

## Key Vault

- Central point for secure secret, key and certificates
- Provides hardened CMK encryption for Storage + VM disks
- Removes key material from VM/Storage reducing risk of compromise
- Enables strict access policies

## Deployment Instructions

## 1. Clone the repository

```powershell
git clone https://github.com/Jammy-1/Azure-NAS-Secure-Ingestion
```

```powershell
cd Azure-NAS-Secure-Ingestion
```

## 2. Prepare variables

- Add information in every fields that has ENTER-INFORMATION
- Change file name terraform.example.tfvars to terraform.tfvars

## 3. Initialize Terraform

```powershell
terraform init
```

## 4. Preview the deployment

```powershell
terraform plan
```

## 5. Input Variables

```powershell
NAS Username
NAS Password
VPN Shared Key
```

## 6. Deploy the infrastructure

```powershell
terraform apply
```
