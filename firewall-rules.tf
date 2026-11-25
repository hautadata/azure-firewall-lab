resource "azurerm_firewall_policy" "lab" {
  name                = "fwpolicy-azure-firewall-lab"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  sku = "Basic"
}

resource "azurerm_firewall_policy_rule_collection_group" "network" {
  name               = "rcg-network"
  firewall_policy_id = azurerm_firewall_policy.lab.id
  priority           = 100

  network_rule_collection {
    name     = "internal-network-rules"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "allow-client-to-server-https"
      protocols             = ["TCP"]
      source_addresses      = azurerm_subnet.client.address_prefixes
      destination_addresses = azurerm_subnet.server.address_prefixes
      destination_ports     = ["443"]
    }
    rule {
      name                  = "allow-client-to-server-sql"
      protocols             = ["TCP"]
      source_addresses      = azurerm_subnet.client.address_prefixes
      destination_addresses = azurerm_subnet.server.address_prefixes
      destination_ports     = ["3306"]
    }
  }

  network_rule_collection {
    name     = "outbound-network-rules"
    priority = 200
    action   = "Allow"

    rule {
      name                  = "allow-client-outbound-http-https"
      protocols             = ["TCP"]
      source_addresses      = azurerm_subnet.client.address_prefixes
      destination_addresses = ["*"]
      destination_ports     = ["80", "443"]
    }
    rule {
      name                  = "allow-server-outbound-http-https"
      protocols             = ["TCP"]
      source_addresses      = azurerm_subnet.server.address_prefixes
      destination_addresses = ["*"]
      destination_ports     = ["80", "443"]
    }
  }
}

## Uncomment below when experimenting DNAT ##

# resource "azurerm_firewall_policy_rule_collection_group" "dnat" {
#   name               = "rcg-dnat"
#   firewall_policy_id = azurerm_firewall_policy.lab.id
#   priority           = 500

#   nat_rule_collection {
#     name     = "inbound-nat-rules"
#     priority = 100
#     action   = "Dnat"

#     rule {
#       name                = "allow-ssh-to-server"
#       protocols           = ["TCP"]
#       source_addresses    = ["${var.admin_source_ip}/32"]
#       destination_address = azurerm_public_ip.firewall.ip_address
#       destination_ports   = ["2222"]
#       translated_address  = azurerm_network_interface.server.private_ip_address
#       translated_port     = 2222
#     }
#   }
# }
