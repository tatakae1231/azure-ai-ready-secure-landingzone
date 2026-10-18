output "orchestrator_identity_id" {
  value       = azurerm_user_assigned_identity.app_orchestrator.id
  description = "Principal ID of the core application orchestrator."
}

output "rag_agent_identity_id" {
  value       = azurerm_user_assigned_identity.rag_agent.id
  description = "Principal ID of the isolated RAG Agentic identity."
}

output "ingestion_agent_identity_id" {
  value       = azurerm_user_assigned_identity.ingestion_agent.id
  description = "Principal ID of the Data Ingestion Agent identity."
}

output "custom_ai_role_id" {
  value       = azurerm_role_definition.ai_agent_query_role.id
  description = "Resource ID of the custom AI Agent Query Operator role."
}
