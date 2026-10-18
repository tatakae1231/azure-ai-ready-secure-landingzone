variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account. Must be globally unique, 3-24 characters, lowercase letters and numbers."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the storage account exists."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. E.g., LRS, GRS, ZRS, GZRS."
  default     = "GRS"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are StorageV2, BlobStorage, BlockBlobStorage, etc."
  default     = "StorageV2"
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This is required for Azure Data Lake Storage Gen2 (ADLS Gen2) used in AI/ML pipelines."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this storage account."
  default     = false
}

variable "shared_key_access_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Number of days that soft-deleted blobs and containers should be retained."
  default     = 30
}

variable "network_rules_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "network_rules_bypass" {
  type        = list(string)
  description = "Specifies whether traffic is bypassed for logging/metrics/azure services. Possible values include AzureServices, Logging, Metrics."
  default     = ["AzureServices", "Logging", "Metrics"]
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP CIDR ranges to allow access to the storage account."
  default     = []
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to allow secure access to the storage account."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
