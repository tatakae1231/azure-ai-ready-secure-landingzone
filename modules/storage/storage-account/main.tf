resource "azurerm_storage_account" "this" {
  name                             = var.storage_account_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  account_kind                     = var.account_kind
  is_hns_enabled                   = var.is_hns_enabled # Hierarchical Namespace (ADLS Gen2) for AI/ML workloads

  min_tls_version                  = "TLS1_2"
  public_network_access_enabled    = var.public_network_access_enabled
  allow_nested_items_to_be_public  = false
  shared_key_access_enabled        = var.shared_key_access_enabled # Enforce Azure Entra ID / Managed Identity where possible

  identity {
    type = "SystemAssigned"
  }

  blob_properties {
    versioning_enabled = true
    change_feed_enabled = true
    
    delete_retention_policy {
      days = var.soft_delete_retention_days
    }
    container_delete_retention_policy {
      days = var.soft_delete_retention_days
    }
  }

  network_rules {
    default_action             = var.network_rules_default_action
    bypass                     = var.network_rules_bypass
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = var.tags
}
