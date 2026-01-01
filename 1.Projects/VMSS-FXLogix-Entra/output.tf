# RG 
output "resource_group_name" { value = module.rg.name }
output "resource_group_id" { value = module.rg.id }

# Network
output "vnet_id" { value = module.network.vnet_id }
output "subnet_ids" { value = module.network.subnet_ids }

# NSG 
output "nsg_id" { value = module.nsg.id }

# AVD
output "avd_host_pool_id" { value = module.avd.host_pool_id }
output "avd_vmss_id" { value = module.avd.vmss_id }
