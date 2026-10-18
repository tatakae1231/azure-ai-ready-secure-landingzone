# 1. Custom Policy Definition: Deny Public AI Endpoints
resource "azurerm_policy_definition" "deny_public_ai" {
  name         = "deny-public-ai-endpoints"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Deny Public Access to Azure AI and Search Services"
  description  = "Enforces zero public internet exposure; requires all AI and Search endpoints to use Private Endpoints."

  management_group_id = var.target_management_group_id
  policy_rule         = file("${path.module}/policies/deny-public-ai-endpoints.json")
}

# 2. Custom Policy Definition: Enforce Local Auth Disabled
resource "azurerm_policy_definition" "enforce_managed_identity_ai" {
  name         = "enforce-ai-local-auth-disabled"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enforce Local Authentication Disabled on AI Services"
  description  = "Mandates that Azure OpenAI and Cognitive Services disable local API keys and rely exclusively on Entra ID."

  management_group_id = var.target_management_group_id
  policy_rule         = file("${path.module}/policies/enforce-ai-local-auth-disabled.json")
}

# 3. Policy Assignment: Deny Public AI Endpoints to AI Workloads MG
resource "azurerm_management_group_policy_assignment" "assign_deny_public_ai" {
  name                 = "deny-public-ai-endpoints"
  management_group_id  = var.target_management_group_id
  policy_definition_id = azurerm_policy_definition.deny_public_ai.id
  display_name         = "Enforce Private Link Only for AI Services"
  description          = "Automated guardrail blocking public network access on AI services under this scope."
}

# 4. Policy Assignment: Enforce Local Auth Disabled
resource "azurerm_management_group_policy_assignment" "assign_enforce_managed_identity" {
  name                 = "enforce-ai-local-auth"
  management_group_id  = var.target_management_group_id
  policy_definition_id = azurerm_policy_definition.enforce_managed_identity_ai.id
  display_name         = "Enforce Managed Identity (Disable Local Auth)"
  description          = "Automated guardrail ensuring zero static API keys are used for AI services."
}
