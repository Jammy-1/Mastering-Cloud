                                        Azure Network Security Group (NSG) Terraform Setup
Overview
Project provisions an Azure Network Security Group (NSG) with customizable security rules.
NSG can be attached to subnets or network interfaces to control inbound and outbound traffic in a secure manner.

Features
-Creates a Resource Group (if not already existing)
-Creates a Network Security Group (NSG)
-Configures multiple NSG rules via a map variable
-Outputs important NSG information for easy reference

Resource Group: Mastering-Terraform-RG
└── Network Security Group: Mastering-Terraform-NSG
    ├─ Security Rules:
    │   ├─ allow-ssh-inbound       (Inbound, TCP 22)
    │   ├─ allow-https-inbound     (Inbound, TCP 443)
    │   └─ deny-all-outbound       (Outbound, Deny All)


How NSG Rules Work:
    -Inbound Rules control traffic coming into your subnet or VM.
    -Outbound Rules control traffic leaving your subnet or VM.
    -Rules are evaluated by priority: lower numbers are evaluated first.
    -Traffic that does not match any rule is denied by default.

Example in this module:
    -SSH access (TCP 22) is allowed from anywhere (0.0.0.0/0).
    -HTTPS traffic (TCP 443) is allowed from anywhere.
    -All other outbound traffic is denied (explicit deny).