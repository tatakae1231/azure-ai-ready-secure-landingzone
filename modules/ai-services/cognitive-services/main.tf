resource "azurerm_cognitive_account" "this" {
  name                          = var.account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = var.kind
  sku_name                      = var.sku_name
  
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled # Enforces Microsoft Entra ID authentication over API keys when false
  custom_subdomain_name         = var.custom_subdomain_name != "" ? var.custom_subdomain_name : var.account_name

  identity {
    type = "SystemAssigned"
  }

  network_acls {
    default_action             = var.network_acls_default_action
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags
}

resource "azurerm_cognitive_deployment" "this" {
  for_each             = var.model_deployments
  name                 = each.key
  cognitive_account_id = azurerm_cognitive_account.this.id

  model {
    format  = each.value.format
    name    = each.value.name
    version = each.value.version
  }

  sku {
    name     = each.value.sku_name
    capacity = each.value.capacity
  }

  dynamic "rai_policy_name" {
    for_each = each.value.rai_policy_name != null ? [each.value.rai_policy_name] : []
    content {
      value = rai_policy_name.value
    }
  }
}
