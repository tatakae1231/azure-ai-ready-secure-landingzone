variable "scope" {
  type        = string
  description = "The scope at which the Role Assignment applies (e.g., Storage Account ID, Key Vault ID, or Resource Group ID)."
}

variable "role_definition_name" {
  type        = string
  description = "The name of a built-in Azure role (e.g., 'Storage Blob Data Contributor', 'Key Vault Secrets User')."
}

variable "principal_id" {
  type        = string
  description = "The ID of the Principal (User, Group, Service Principal, or Managed Identity) to assign the role to."
}
