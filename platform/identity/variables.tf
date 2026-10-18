variable "resource_group_name" {
  type        = string
  description = "Resource group name for platform identity and RBAC definitions."
  default     = "rg-az-ai-slz-identity"
}

variable "location" {
  type        = string
  description = "Azure region for identity-related resources."
  default     = "southeastasia"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for identity resources."
  default     = "az-ai-slz"
}

variable "tags" {
  type        = map(string)
  description = "Default resource tags."
  default = {
    Environment = "Platform"
    LandingZone = "Identity"
  }
}
