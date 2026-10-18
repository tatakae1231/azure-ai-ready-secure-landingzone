output "id" { value = azurerm_policy_assignment.this.id }
output "identity_principal_id" { value = try(azurerm_policy_assignment.this.identity[0].principal_id, null) }
