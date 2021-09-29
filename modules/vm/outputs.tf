output "object" {
  value       = var.is_linux ? azurerm_linux_virtual_machine.vm[0] : azurerm_windows_virtual_machine.vm[0]
  description = "The full vm object."
}

output "id" {
  value       = var.is_linux ? azurerm_linux_virtual_machine.vm[0].id : azurerm_windows_virtual_machine.vm[0].id
  description = "The vm id."
}

output "name" {
  value       = var.is_linux ? azurerm_linux_virtual_machine.vm[0].name : azurerm_windows_virtual_machine.vm[0].name
  description = "The vm name"
}
