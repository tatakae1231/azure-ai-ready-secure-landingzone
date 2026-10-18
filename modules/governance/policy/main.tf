resource "azurerm_policy_assignment" "this" {
  name                 = var.name
  resource_group_id    = var.resource_group_id
  scope                = var.scope
  policy_definition_id = var.policy_definition_id
  description          = var.description
  display_name         = var.display_name
  parameters           = var.parameters

  identity {
    type = "SystemAssigned"
  }
}
