output "deny_public_ai_policy_id" {
  value       = azurerm_policy_definition.deny_public_ai.id
  description = "The resource ID of the custom deny public AI endpoints policy."
}

output "enforce_local_auth_policy_id" {
  value       = azurerm_policy_definition.enforce_managed_identity_ai.id
  description = "The resource ID of the custom local auth restriction policy."
}
