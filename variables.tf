#================================================================================================
# Environment Vars - Global
#================================================================================================
# Service Principal
variable "sp-subscription-id" {
  description = "Id of the azure subscription where all resources will be created"
  type        = string
}
variable "sp-client-id" {
  description = "Client Id of A Service Principal or Azure Active Directory application registration used for provisioning azure resources."
  type        = string
}
variable "sp-client-secret" {
  description = "Secret of A Service Principal or Azure Active Directory application registration used for provisioning azure resources."
  type        = string
}
variable "sp-tenant-id" {
  description = "Tenant Id of the azure account."
  type        = string
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project" = "dify"
  }
}

#================================================================================================
# Environment Vars
#================================================================================================
# Azure resources

variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  type        = string
  default     = "East US"
}

variable "name" {
  description = "Name of the main resource name"
  type        = string
  default     = "dify"
}

variable "environment" {
  default = "dev"
}

#================================================================================================
# Networks
#================================================================================================
variable "vnet" {}    # The vnet cidr.
variable "subnets" {} # A list of subnet cidrs.

variable "kubernetes_version" {
  default = "1.29.1"
}

variable "node_count" {
  default = "1"
}

variable "vm_size" {}

variable "max_pods" {
  default = "30"
}

variable "redis_cache_enabled" {
  default = true
}

variable "redis_cache_family" {
  default = "C"
}

variable "redis_cache_sku" {
  default = "Basic"
}

variable "redis_cache_capacity" {
  default = "1"
}

variable "redis_cache_prefix" {
  default = "redis"
}

variable "redis_cache_name" {
  default = "cache"
}

variable "redis_public_network_access_enabled" {
  default = true
}


variable "pgsql_admin_login" {
  default = "postgres"
}

variable "pgsql_admin_password" {
  default = "Test1234t"
}

variable "pgsql_storage_mb" {
  default = "262144"
}

variable "pgsql_version" {
  default = "15"
}

variable "pgsql_sku_name" {
  default = "GP_Standard_D2s_v3"
}

variable "filename" {
}

