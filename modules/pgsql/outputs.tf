output "pgsql_host" {
  description = "The hostname for the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.pgsql.fqdn
}


output "pgsql_username" {
  description = "The username for the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.pgsql.administrator_login
}

output "pgsql_password" {
  description = "The password for the PostgreSQL server"
  value       = var.pgsql_admin_password
}