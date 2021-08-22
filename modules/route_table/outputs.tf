output "route_table" {
  value = azurerm_route_table.route_table
  description = "The full route table object."
}

output "id" {
  value = azurerm_route_table.route_table.id
  description = "The route table id."
}

output "name" {
  value = azurerm_route_table.route_table.name
  description = "The route table name"
}