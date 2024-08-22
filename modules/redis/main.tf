resource "azurerm_redis_cache" "redis" {
  # count                         = var.redis_cache_enabled ? 1 : 0
  name                          = var.redis_cache_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  capacity                      = var.redis_cache_capacity
  family                        = var.redis_cache_family
  sku_name                      = var.redis_cache_sku
  enable_non_ssl_port           = true
  # minimum_tls_version           = "1.2"
  public_network_access_enabled = var.redis_public_network_access_enabled
  # subnet_id = azurerm_subnet.redis.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}