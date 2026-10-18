variable "root_management_group_id" {
  type        = string
  description = "The ID or Name of the Tenant Root Management Group."
}

variable "resource_prefix" {
  type        = string
  description = "Prefix applied to all management group display names and IDs."
  default     = "az-ai-slz"
}

variable "subscription_ids" {
  type = object({
    connectivity = optional(list(string), [])
    identity     = optional(list(string), [])
    management   = optional(list(string), [])
    ai_workloads = optional(list(string), [])
  })
  description = "Map of subscription IDs to associate with specific management groups."
  default     = {}
}
