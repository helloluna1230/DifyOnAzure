// ========================== PostgreSQL ==========================
variable "resource_group_name" {}
variable "location" {}
variable "pgsql_name" {}
variable "zone_name" {}
variable "vnet_name" {}
variable "vnet_id" {}


variable "pgsql_sku_name" {
  description = "(Optional) The SKU Name for the PostgreSQL Flexible Server. The name of the SKU, follows the tier + name pattern (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3). "
  type        = string
  default     = "GP_Standard_D2s_v3"

  validation {
    condition     = contains(["B_Standard_B1ms", "GP_Standard_D2s_v3", "MO_Standard_E4s_v3"], var.pgsql_sku_name)
    error_message = "The value of the sku name property of the PostgreSQL is invalid."
  }
}
variable "pgsql_tags" {
  description = "(Optional) A mapping of tags which should be assigned to the PostgreSQL Flexible Server."
  type        = map(any)
  default     = {}
}
variable "pgsql_admin_password" {
  description = "(Optional) Admin password of the PostgreSQL server"
  type        = string
  default     = "Test1234t"
}
variable "pgsql_admin_login" {
  description = "(Optional) Admin username of the PostgreSQL server"
  type        = string
  default     = "postgres"
}
variable "pgsql_version" {
  description = "(Optional) The version of PostgreSQL Flexible Server to use. Possible values are 11,12, 13, 14 and 15. Required when create_mode is Default."
  type        = string
  default     = "15"
  validation {
    condition     = contains(["11", "12", "13", "14", "15","16"], var.pgsql_version)
    error_message = "The value of the version property of the PostgreSQL is invalid."
  }
}
variable "pgsql_storage_mb" {
  description = "(Optional) The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216 and 33553408."
  type        = string
  default     = "262144"
}
variable "postgresql_configurations" {
  description = "PostgreSQL configurations to enable."
  type        = map(string)
  default = {
    "pgbouncer.enabled" = "true",
    "azure.extensions"  = "PG_TRGM"
  }
}

variable "pgsql_vnet_subnet_id" {
  description = "The subnet id for the database."
  type        = string
}