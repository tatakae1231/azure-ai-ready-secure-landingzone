output "id" {
  description = "The ID of the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.id
}

output "name" {
  description = "The name of the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.name
}

output "endpoint" {
  description = "The endpoint URL of the Cognitive Service Account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "primary_access_key" {
  description = "Primary access key for the cognitive account (sensitive)."
  value       = azurerm_cognitive_account.this.primary_access_key
  sensitive   = true
}

output "deployment_ids" {
  description = "Map of model deployment names to their IDs."
  value       = { for k, d in azurerm_cognitive_deployment.this : k => d.id }
}
