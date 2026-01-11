output "resource_group_name" { value = var.resource_group_name }


output "vmss_per_region" {
  value = {
    for region, vmss_module in module.vmss :
    region => {
      name  = vmss_module.vmss_name
      zones = vmss_module.vmss_zones
    }
  }
}

output "deploy_regions" { value = local.deploy_regions }

output "region_zones" {
  value = local.region_zones
}

output "public_ip" {
  value = {
    for region, lb in module.lb :
    region => lb.public_ip
  }
}

output "subnet_name" {
  value = {
    for region, net in module.network :
    region => net.subnet_name
  }
}

output "backend_pool_name" {
  value = {
    for region, lb in module.lb :
    region => lb.backend_address_pool_name
  }
}

output "webserver_ips" {
  value = [
    for region in sort(keys(module.lb)) : "http://${module.lb[region].public_ip}"
  ]
}
