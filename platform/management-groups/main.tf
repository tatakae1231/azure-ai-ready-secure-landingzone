# 1. Enterprise Landing Zones Parent Management Group
resource "azurerm_management_group" "landing_zones" {
  name                       = "${var.resource_prefix}-elz"
  display_name               = "Enterprise Landing Zones"
  parent_management_group_id = var.root_management_group_id
}

# 2. Platform Management Group (Hub, Security, Ops)
resource "azurerm_management_group" "platform" {
  name                       = "${var.resource_prefix}-platform"
  display_name               = "Platform"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "connectivity" {
  name                       = "${var.resource_prefix}-connectivity"
  display_name               = "Connectivity (Hub)"
  parent_management_group_id = azurerm_management_group.platform.id
  subscription_ids           = var.subscription_ids.connectivity
}

resource "azurerm_management_group" "identity" {
  name                       = "${var.resource_prefix}-identity"
  display_name               = "Identity & Security"
  parent_management_group_id = azurerm_management_group.platform.id
  subscription_ids           = var.subscription_ids.identity
}

resource "azurerm_management_group" "management" {
  name                       = "${var.resource_prefix}-management"
  display_name               = "Management & Ops"
  parent_management_group_id = azurerm_management_group.platform.id
  subscription_ids           = var.subscription_ids.management
}

# 3. Workloads Management Group (Where AI & Data live)
resource "azurerm_management_group" "workloads" {
  name                       = "${var.resource_prefix}-workloads"
  display_name               = "Workloads"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "ai_workloads" {
  name                       = "${var.resource_prefix}-ai-workloads"
  display_name               = "AI Landing Zones"
  parent_management_group_id = azurerm_management_group.workloads.id
  subscription_ids           = var.subscription_ids.ai_workloads
}
