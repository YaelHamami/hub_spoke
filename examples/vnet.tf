module "hub_vnet" {
  source              = "relative/path/to-file"
  resource_group_name = local.hub_resource_group_name
  name                = local.hub_vnet_name
  location            = local.location
  address_space       = ["10.1.0.0/24"]
  subnets = [
    {
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.1.0.0/26"]
    },
    {
      name             = "GatewaySubnet"
      address_prefixes = ["10.1.0.128/27"]
    }
  ]
  depends_on = [azurerm_resource_group.hub]
}