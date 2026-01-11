# General 
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

# Eventhub 
variable "eventhub_namespace" { type = string }
variable "eventhub_name" { type = string }
variable "eventhub_auth_rule_name" { type = string }

