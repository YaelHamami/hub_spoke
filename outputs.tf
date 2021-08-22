output "template" {
  value = templatefile("template.tmpl",
  {
    "prefixes"           = local.prefixes
    "network-rules"      = local.network_rules
    "hub-routes"         = local.hub_routes
    "spoke-routes"       = local.spoke_routes
    "storage-data-disks" = local.storage_data_disks
  })
}