output "policy" {
  value = azurerm_firewall_policy.policy.id
  description = "The full firewall policy object."
}

output "id" {
  value       = azurerm_firewall_policy.policy.id
  description = "The id of the policy."
}

output "name" {
  value = azurerm_firewall_policy.policy.name
  description = "The name of the firewall policy."
}