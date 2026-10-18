resource "azurerm_storage_share" "this" {
  name                 = var.share_name
  storage_account_name = var.storage_account_name
  quota                = var.quota_in_gb
  enabled_protocol     = var.enabled_protocol # "SMB" or "NFS"
  access_tier          = var.access_tier      # "Hot", "Cool", "Premium"
}
