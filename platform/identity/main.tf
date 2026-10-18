resource "azurerm_resource_group" "identity" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# -----------------------------------------------------------------------------
# A. MACHINE & AGENTIC AI MANAGED IDENTITIES (UAMIs)
# -----------------------------------------------------------------------------

# 1. Core Application / Orchestrator Identity
resource "azurerm_user_assigned_identity" "app_orchestrator" {
  name                = "${var.resource_prefix}-uami-orchestrator"
  resource_group_name = azurerm_resource_group.identity.name
  location            = azurerm_resource_group.identity.location
  tags                = var.tags
}

# 2. Agentic AI Identity: RAG Retrieval Agent (Read-only access to vector store)
resource "azurerm_user_assigned_identity" "rag_agent" {
  name                = "${var.resource_prefix}-uami-agent-rag"
  resource_group_name = azurerm_resource_group.identity.name
  location            = azurerm_resource_group.identity.location
  tags                = merge(var.tags, { Role = "Autonomous-RAG-Agent" })
}

# 3. Agentic AI Identity: Data Ingestion Agent (Write access to vector store & blob storage)
resource "azurerm_user_assigned_identity" "ingestion_agent" {
  name                = "${var.resource_prefix}-uami-agent-ingestion"
  resource_group_name = azurerm_resource_group.identity.name
  location            = azurerm_resource_group.identity.location
  tags                = merge(var.tags, { Role = "Autonomous-Ingestion-Agent" })
}


# -----------------------------------------------------------------------------
# B. CUSTOM RBAC ROLES FOR AI AGENTS (Least Privilege Enforcement)
# -----------------------------------------------------------------------------

# Custom Role for AI Inference & Vector Search Querying only (No admin rights)
resource "azurerm_role_definition" "ai_agent_query_role" {
  name        = "AI Agent Secure Query Operator"
  scope       = azurerm_resource_group.identity.id
  description = "Custom least-privilege role allowing model inferencing and vector search queries, denying administrative mutations."

  permissions {
    actions = [
      "Microsoft.CognitiveServices/accounts/deployments/predict/action",
      "Microsoft.Search/searchServices/query/action"
    ]
    not_actions = [
      "Microsoft.CognitiveServices/accounts/write",
      "Microsoft.CognitiveServices/accounts/delete",
      "Microsoft.Search/searchServices/write",
      "Microsoft.Search/searchServices/delete"
    ]
  }

  assignable_scopes = [
    azurerm_resource_group.identity.id
  ]
}
