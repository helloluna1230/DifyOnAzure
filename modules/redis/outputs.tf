output "redis_cache_primary_access_key" {
  description = "The Primary Access Key for the Redis Instance"
  value = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_cache_port" {
  description = "The non-SSL Port of the Redis Instance"
  value = azurerm_redis_cache.redis.port
  sensitive   = true
}

output "redis_cache_hostname" {
  description = "The Hostname of the Redis Instance"
  value = azurerm_redis_cache.redis.hostname
}