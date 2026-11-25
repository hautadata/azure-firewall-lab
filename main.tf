resource "azurerm_resource_group" "lab" {
  name     = "rg-azure-firewall-lab"
  location = var.location
}