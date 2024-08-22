variable "redis_cache_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "redis_cache_sku" {
  description = " (Required) The SKU of Redis to use. Possible values are Basic, Standard and Premium."
  type        = string
}

variable "redis_cache_capacity" {
  description = "(Required) The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5."
  type        = string
}

variable "redis_cache_family" {
  description = " (Required) The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
  type        = string
}


variable "redis_public_network_access_enabled" {
  description = " (Optional) Whether or not public network access is allowed for this Redis Cache. true means this resource could be accessed by both public and private endpoint. false means only private endpoint access is allowed. Defaults to true."
  type        = bool
  default     = false
}

variable "redis_enable_authentication" {
  description = " (Optional) If set to false, the Redis instance will be accessible without authentication. Defaults to true."
  type        = bool
  default     = true
}
variable "redis_pe_core_enabled" {
  description = " (Optional) Enable core subscription private endpoint"
  type        = bool
  default     = false
}
variable "private_endpoint_prefix" {
  type        = string
  default     = "pe"
  description = "Prefix of the Private Endpoint name that's combined with name of the Private Endpoint."
}