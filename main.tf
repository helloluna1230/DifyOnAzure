resource "azurerm_resource_group" "rg" {
  name     = lower("${var.name}-${var.environment}-rg")
  location = var.location
}

module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = lower("${var.name}-${var.environment}-vnet")
  location            = var.location
  vnet                = var.vnet    # The vnet cidr.
  subnets             = var.subnets # The list of subnet cidrs.
}

module "redis" {
  source                              = "./modules/redis"
  redis_cache_name                    = "${var.name}-${var.environment}-redis"
  resource_group_name                 = azurerm_resource_group.rg.name
  location                            = var.location
  redis_cache_capacity                = var.redis_cache_capacity
  redis_cache_family                  = var.redis_cache_family
  redis_cache_sku                     = var.redis_cache_sku
  redis_public_network_access_enabled = var.redis_public_network_access_enabled
    depends_on = [module.subnet]
}

module "pgsql" {
  source = "./modules/pgsql"

  pgsql_name           = "${var.name}-${var.environment}-pgsql"
  zone_name            = "${var.name}-${var.environment}-zone"
  location             = var.location
  vnet_name            = module.subnet.vnet_name
  vnet_id              = module.subnet.vnet_id
  resource_group_name  = azurerm_resource_group.rg.name
  pgsql_version        = var.pgsql_version
  pgsql_admin_login    = var.pgsql_admin_login
  pgsql_admin_password = var.pgsql_admin_password
  pgsql_sku_name       = var.pgsql_sku_name
  pgsql_storage_mb     = var.pgsql_storage_mb
  pgsql_vnet_subnet_id = module.subnet.subnet_ids.snet-db # The subnet id for the database.
  zone                 = var.pg_zone

  depends_on = [module.subnet]
}

module "aks" {
  source = "./modules/aks"
  location            = var.location
  aks_name            = "${var.name}-${var.environment}-aks"
  kubernetes_version  = var.kubernetes_version
  node_count          = var.node_count
  vm_size             = var.vm_size
  max_pods            = var.max_pods
  resource_group_name = azurerm_resource_group.rg.name
  subnet_aks          = module.subnet.subnet_ids.snet-aks
  appgw_name          = "${var.name}-${var.environment}-appgw"
  subnet_appgw        = module.subnet.subnet_ids.snet-appgw
  depends_on          = [module.subnet, module.redis, module.pgsql]
  vnet_id             = module.subnet.vnet_id
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks] # refresh cluster state before reading
  name                = module.aks.aks_name
  resource_group_name = azurerm_resource_group.rg.name
}

/*
provider "helm" {
  kubernetes {
    #host                   = data.azurerm_kubernetes_cluster.default.kube_config.0.host
    host = module.aks.fqdn
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}
*/

resource "null_resource" "wait_for_kubeconfig" {
  provisioner "local-exec" {
    command =  "az aks get-credentials --resource-group ${azurerm_resource_group.rg.name} --name ${var.name}-${var.environment}-aks"
    working_dir = path.module
  }
}

resource "local_file" "kubeconfig" {
  content = data.azurerm_kubernetes_cluster.default.kube_config_raw
  filename = var.filename
  depends_on = [null_resource.wait_for_kubeconfig]

}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}

provider "helm" {
    kubernetes {
      config_path = local_file.kubeconfig.filename
    }
}

module "dify" {
  source       = "./modules/dify"
  pgsql_admin_login = var.pgsql_admin_login
  pgsql_admin_password = var.pgsql_admin_password
  pgsql_fqdn = module.pgsql.pgsql_host
  redis_cache_host = module.redis.redis_cache_hostname
  redis_cache_password = module.redis.redis_cache_primary_access_key
  pgvector_username = var.pgsql_admin_login
  pgvector_password = var.pgsql_admin_password
  pgvector_fqdn = module.pgsql.pgsql_host

  depends_on   = [local_file.kubeconfig]
}
