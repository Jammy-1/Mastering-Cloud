# Regions
module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "0.9.2"
}

locals {
  primary_region = [
    for r in module.regions.regions : r
    if lower(r.name) == lower(var.location)
  ][0]

  paired_region = try([
    for r in module.regions.regions :
    r if r.name == local.primary_region.paired_region_name
  ][0], null)
  
  deploy_regions = (
    local.paired_region == null ?
    [local.primary_region] :
    [local.primary_region, local.paired_region]
  )

  region_zones = {
    for r in local.deploy_regions :
    r.name => (
      try(r.zones, null) != null && length(r.zones) > 0 ?
      r.zones : null
    )
  }
  deploy_matrix = {
    for r in local.deploy_regions :
    r.name => {
      region    = r.name
      zones     = lookup(local.region_zones, r.name, null)
      use_zones = lookup(local.region_zones, r.name, null) != null
    }
  }
}