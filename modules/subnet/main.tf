resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet]
}

# Create the subnets.
resource "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.subnets : subnet.name => subnet } # For each loop (for_each needs a map; this { for } loop converts it.
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]

  dynamic "delegation" {
    for_each = each.value.name == "snet-db" ? [1] : []
    content {
      name = "delegation"

      service_delegation {
        name    = "Microsoft.DBforPostgreSQL/flexibleServers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}
