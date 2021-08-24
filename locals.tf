locals {
  tenant_id       = "c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
  subscription_id = "d94fe338-52d8-4a44-acd4-4f8301adf2cf"
  prefixes        = {
    hub_prefix   = "daniel-hub"
    spoke_prefix = "daniel-spoke"
  }
  location        = "West Europe"
}

//hub related locals
locals {

  hub_resource_group_name = "${local.prefixes.hub_prefix}-rg"

  hub_vnet_name          = "${local.prefixes.hub_prefix}-vnet"
  hub_address_space      = ["10.1.0.0/24"]
  hub_vnet_address_space = ["10.1.0.0/24"]
  hub_vnet_dns_servers   = ["10.1.0.4", "10.1.0.5"]

  firewall_subnet_address_prefixes = ["10.1.0.0/26"]

  gateway_subnet_address_prefixes = ["10.1.0.128/27"]

  log_workspace_name = "${local.prefixes.hub_prefix}-logs-workspace"
  log_workspace_sku  = "PerGB2018"

  hub_firewall_name        = "${local.prefixes.hub_prefix}-firewall"
  hub_firewall_policy_name = "${local.prefixes.hub_prefix}-firewall-policy"
  network_rules            = jsondecode(templatefile("./templates/rules/network_rules.json", {
    vpn_client_address_space = module.vpn.client_address_space
  })).rules

  vpn_client_address_space = ["192.168.0.0/24"]
  aad_tenant               = "https://login.microsoftonline.com/${local.tenant_id}"
  aad_issuer               = "https://sts.windows.net/${local.tenant_id}/"
  audience_id              = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"

  virtual_gateway_name = "${local.prefixes.hub_prefix}-virtual-gateway"
  hub_routes           = jsondecode(templatefile("./templates/routes/hub_gateway_routes.json", {
    "destination_address_prefix" = azurerm_subnet.GatewaySubnet.address_prefixes[0]
    "firewall_private_ip"        = module.firewall.private_ip
  })).hub_gateway_routes

  gateway_route_table_name = "${local.prefixes.hub_prefix}-firewall-to-spoke-route-table"
}

//spoke related locals
locals {

  spoke_resource_group_name = "${local.prefixes.spoke_prefix}-spoke-rg"

  spoke_vnet_address_space = ["10.0.0.0/24"]
  spoke_vnet_dns_servers   = ["10.0.0.4", "10.0.0.5"]

  spoke_subnet_name             = "spoke-subnet"
  spoke_subnet_address_prefixes = ["10.0.1.0/24"]

  spoke_vm_name = "vm"

  spoke_route_table_name = "${local.prefixes.spoke_prefix}-spoke-out"
  spoke_routes           = jsondecode(templatefile("./templates/routes/spoke_routes.json", {
    "destination_address_prefix" = module.vpn.client_address_space
    "firewall_private_ip"        = module.firewall.private_ip
  })).spoke_routes

  storage_data_disks = jsondecode(templatefile("./templates/storage/storage_data_disks.json", {
    "destination_address_prefix" = module.vpn.client_address_space
    "firewall_private_ip"        = module.firewall.private_ip
  })).storage_data_disks
}