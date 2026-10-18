resource "azurerm_storage_management_policy" "this" {
  storage_account_id = var.storage_account_id

  rule {
    name    = var.rule_name
    enabled = true

    filters {
      blob_types   = var.blob_types # ["blockBlob"]
      prefix_match = var.prefix_match
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = var.cool_after_days
        tier_to_archive_after_days_since_modification_greater_than = var.archive_after_days
        delete_after_days_since_modification_greater_than          = var.delete_after_days
      }
      snapshot {
        delete_after_days_since_creation_greater_than = var.snapshot_delete_after_days
      }
    }
  }
}
