                                    Azure Virtual Network (VNet) Terraform Setup
Overview
Terraform project provisions an Azure Virtual Network (VNet) with multiple subnets. 
Designed to create a secure and well organized network foundation for deploying workloads in Azure.

Features
-Creates a Resource Group
-Creates a Virtual Network (VNet) with configurable address spaces and DNS servers
-Creates multiple subnets with custom address prefixes
-Outputs key information about the VNet and subnets for easy reference

Resource Group: MasteringTF-ResourceGroup
└── Virtual Network: MyVNet (10.0.0.0/16)
    ├── DNS Servers: 10.0.0.4, 10.0.0.5
    ├── Subnet1: 10.0.1.0/24
    └── Subnet2: 10.0.2.0/24


Network Structure
    -The VNet defines the overall address space (10.0.0.0/16) for your Azure deployment.
    -Each subnet reserves a portion of the VNet IP space for specific workloads or services.
    -Custom DNS servers can be defined at the VNet level to resolve internal or external domain names.
    -Subnets can later be associated with NSGs, route tables, or service endpoints to enforce security and routing.