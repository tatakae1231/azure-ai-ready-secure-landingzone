variable "defender_plans" {
  type = map(object({
    tier    = string
    subplan = optional(string)
  }))
  description = "Map of Defender resource types (e.g., 'StorageAccounts', 'KeyVaults', 'Arm', 'OpenAI') to their pricing tier ('Standard' or 'Free')."
  default     = {}
}
