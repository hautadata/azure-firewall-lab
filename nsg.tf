
resource "azurerm_network_security_group" "server" {
  name                = "nsg-server"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "allow-bastion-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_subnet.bastion.address_prefixes[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-client-app"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443", "3306"]
    source_address_prefix      = azurerm_subnet.client.address_prefixes[0]
    destination_address_prefix = "*"
  }

  ## Uncomment below when experimenting DNAT ##

  # security_rule {
  #   name                       = "allow-firewall-dnat-ssh"
  #   priority                   = 120
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "22"
  #   source_address_prefix      = azurerm_subnet.firewall.address_prefixes[0]
  #   destination_address_prefix = "*"
  # }

  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "client" {
  name                = "nsg-client"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "allow-bastion-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_subnet.bastion.address_prefixes[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "server" {
  subnet_id                 = azurerm_subnet.server.id
  network_security_group_id = azurerm_network_security_group.server.id
}

resource "azurerm_subnet_network_security_group_association" "client" {
  subnet_id                 = azurerm_subnet.client.id
  network_security_group_id = azurerm_network_security_group.client.id
}
