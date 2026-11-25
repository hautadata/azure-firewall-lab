output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "resource_group_location" {
  value = azurerm_resource_group.lab.location
}

output "hub_virtual_network_name" {
  value = azurerm_virtual_network.hub.name
}

output "client_virtual_network_name" {
  value = azurerm_virtual_network.client.name
}

output "server_virtual_network_name" {
  value = azurerm_virtual_network.server.name
}

output "client_private_ip" {
  value = azurerm_network_interface.client.private_ip_address
}

output "server_private_ip" {
  value = azurerm_network_interface.server.private_ip_address
}

output "firewall_private_ip" {
  value = azurerm_firewall.lab.ip_configuration[0].private_ip_address
}

output "firewall_public_ip" {
  value = azurerm_public_ip.firewall.ip_address
}
