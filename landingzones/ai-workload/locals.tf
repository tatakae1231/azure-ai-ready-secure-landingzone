# landingzones/ai-workload/locals.tf
locals {
  name_prefix = "slz-${var.environment}-${var.location}"

  common_tags = merge(
    var.base_tags,
    {
      Environment        = var.environment
      ManagedBy          = "Terraform"
      LandingZone        = "AI-Workload"
      DeploymentLocation = var.location
    }
  )
}
