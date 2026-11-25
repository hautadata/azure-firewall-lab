resource "azurerm_route_table" "client" {
  name                = "rt-client"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  route {
    name                   = "server-via-firewall"
    address_prefix         = azurerm_subnet.server.address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.lab.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "internet-via-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.lab.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_route_table" "server" {
  name                = "rt-server"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  route {
    name                   = "client-via-firewall"
    address_prefix         = azurerm_subnet.client.address_prefixes[0]
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.lab.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "internet-via-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.lab.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "client" {
  subnet_id      = azurerm_subnet.client.id
  route_table_id = azurerm_route_table.client.id
}

resource "azurerm_subnet_route_table_association" "server" {
  subnet_id      = azurerm_subnet.server.id
  route_table_id = azurerm_route_table.server.id
}
