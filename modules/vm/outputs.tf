output "vm" {
  value       = azurerm_linux_virtual_machine.vm
  description = "The full vm object."
}

output "id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The vm id."
}

output "name" {
  value       = azurerm_linux_virtual_machine.vm.name
  description = "The vm name"
}