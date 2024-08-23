# Create private DNS zone for PostgreSQL 
resource "azurerm_private_dns_zone" "pgsql_dns_zone" {
  name                = "${var.zone_name}.private.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = [
      # tags
    ]
  }
}

# Associate PostgreSQL Private DNS zone with virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "pgsql_dns_zone_vnet_associate" {
  name                  = "link-to-${var.vnet_name}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pgsql_dns_zone.name
  virtual_network_id    = var.vnet_id

  lifecycle {
    ignore_changes = [
      # tags
    ]
  }

  depends_on = [
    azurerm_private_dns_zone.pgsql_dns_zone
  ]
}

# Create the Azure PostgreSQL - Flexible Server using terraform
resource "azurerm_postgresql_flexible_server" "pgsql" {
  name                   = var.pgsql_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.pgsql_version
  public_network_access_enabled = false
  delegated_subnet_id    = "${ var.pgsql_vnet_subnet_id}"
  private_dns_zone_id    = azurerm_private_dns_zone.pgsql_dns_zone.id
  administrator_login    = var.pgsql_admin_login
  administrator_password = var.pgsql_admin_password
  zone                   = var.pg_zone
  storage_mb = var.pgsql_storage_mb

  # Set the backup retention policy to 7 for non-prod, and 30 for prod
  backup_retention_days = 7

  sku_name = var.pgsql_sku_name
  depends_on = [
    azurerm_private_dns_zone.pgsql_dns_zone
  ]
  lifecycle {
    ignore_changes = [
      # tags,
      # private_dns_zone_id
    ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "dify" {
  name      = "dify"
  server_id = azurerm_postgresql_flexible_server.pgsql.id
  collation = "en_US.utf8"
  charset   = "utf8"

  depends_on = [
    azurerm_postgresql_flexible_server.pgsql
  ]

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_postgresql_flexible_server_database" "pgvector" {
  name      = "pgvector"
  server_id = azurerm_postgresql_flexible_server.pgsql.id
  collation = "en_US.utf8"
  charset   = "utf8"

# prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
}

resource "azurerm_postgresql_flexible_server_configuration" "extension" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.pgsql.id
  value     = "vector,uuid-ossp"
}