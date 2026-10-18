variable "target_management_group_id" {
  type        = string
  description = "The Management Group ID where governance policies will be assigned (e.g., AI Workloads MG ID)."
}

variable "environment" {
  type        = string
  description = "Environment name for tagging assignments (e.g., prod, shared)."
  default     = "prod"
}
