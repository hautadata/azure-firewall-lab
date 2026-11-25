resource "azurerm_log_analytics_workspace" "lab" {
  name                = "law-azure-firewall-lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "firewall" {
  name                           = "firewall-logs"
  target_resource_id             = azurerm_firewall.lab.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.lab.id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "AZFWNetworkRule"
  }

  enabled_log {
    category = "AZFWNatRule"
  }
}