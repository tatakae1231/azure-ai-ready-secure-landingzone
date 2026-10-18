variable "key_vault_name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the Key Vault should exist."
}

variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are 'standard' or 'premium'."
  default     = "standard"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted. Possible values are between 7 and 90 days."
  default     = 90
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault? Once enabled, purge protection cannot be disabled."
  default     = true
}

variable "network_acls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "network_acls_bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules. Possible values are 'AzureServices' and 'None'."
  default     = "AzureServices"
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "One or more IP Addresses, or CIDR blocks, which should be able to access the Key Vault."
  default     = []
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "One or more Subnet IDs which should be able to access the Key Vault."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
