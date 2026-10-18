variable "account_name" {
  type        = string
  description = "Specifies the name of the Cognitive Service Account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Cognitive Service Account."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "kind" {
  type        = string
  description = "The kind of Cognitive Service. E.g., 'OpenAI', 'CognitiveServices', 'AIServices'."
  default     = "OpenAI"
}

variable "sku_name" {
  type        = string
  description = "The SKU name of the Cognitive Service account. E.g., 'S0'."
  default     = "S0"
}

variable "custom_subdomain_name" {
  type        = string
  description = "The subdomain name used for token-based authentication. Required for Private Endpoints."
  default     = ""
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this cognitive account."
  default     = false
}

variable "local_auth_enabled" {
  type        = bool
  description = "Whether local authentication (API keys) is enabled. Recommended false for enterprise security (Entra ID only)."
  default     = false
}

variable "network_acls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match. Possible values are Allow and Deny."
  default     = "Deny"
}

variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP CIDR ranges permitted to access the cognitive account."
  default     = []
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs permitted to access the cognitive account."
  default     = []
}

variable "model_deployments" {
  type = map(object({
    format          = string
    name            = string
    version         = string
    sku_name        = string
    capacity        = number
    rai_policy_name = optional(string)
  }))
  description = "Map of AI model deployments (e.g., GPT-4o, Embeddings) to configure on the account."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
