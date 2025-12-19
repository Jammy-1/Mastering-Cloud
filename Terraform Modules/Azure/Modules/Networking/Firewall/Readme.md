                                                        Azure Firewall Terraform Setup

Overview
 Project provisions a secure Azure virtual network environment with:

- Resource Group
- Virtual Network (VNet)

Two subnets:

    - Regular Subnet — for workloads, protected by NSG and routed through the firewall

    - Firewall Subnet — dedicated subnet for Azure Firewall (AzureFirewallSubnet)

- Network Security Group (NSG) for the regular subnet

- Azure Firewall with a public IP

- Route Table (UDR) for routing traffic from the regular subnet through the firewall

Firewall Rules (configured via terraform.tfvars)

This setup ensures all outbound traffic from workloads is inspected and controlled by Azure Firewall.

Resource Group: my-firewall-rg
└── Virtual Network: my-vnet (10.0.0.0/16)
    ├── Regular Subnet: 10.0.0.0/24
    │   ├─ Network Security Group: Mastering-subnet-nsg
    │   └─ Route Table: routes all traffic (0.0.0.0/0) through Firewall
    └── AzureFirewallSubnet: 10.0.1.0/24
        └─ Azure Firewall: my-firewall
            └─ Public IP: fw-public-ip

How Traffic is Routed

- All outbound traffic from the regular subnet is routed via the Route Table to the Azure Firewall.
- The firewall inspects traffic according to the rules defined in firewall_network_rules.
- Allowed traffic (e.g., TCP 80/443) exits to the internet via the firewall’s public IP.
- All other traffic is blocked by default (explicit deny rule).