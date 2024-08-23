# Login to Azure using service principal, and set the subscription id, client id, client secret and tenant id
sp-subscription-id = <subscription-id>
sp-client-id = <client-id>
sp-client-secret = <client-secret>
sp-tenant-id = <tenant-id>

name = "dify"
environment = "prod"
location = "eastus2"

#subnet

#================================================================================================
# Networks
#================================================================================================
vnet = "10.11.0.0/16"
subnets = [
  {
    name           = "snet-aks"
    address_prefix = "10.11.1.0/24"
  },
  {
    name           = "snet-appgw"
    address_prefix = "10.11.2.0/24"
  },
  {
    name           = "snet-db"
    address_prefix = "10.11.3.0/24"
  }
]


#redis
# Redis Cache
redis_cache_capacity               = 1
redis_cache_family                 = "C" 
redis_cache_sku                    = "Basic"
redis_public_network_access_enabled= true



# PostgreSQL
pgsql_sku_name                       = "B_Standard_B1ms"
pgsql_admin_login                    = "postgres"
pgsql_admin_password                 = "Test1234t"
pgsql_version                        = "15"
pgsql_storage_mb                     = "32768"
pg_zone                                 = "1"

# aks
kubernetes_version = "1.28.9"
node_count = 1
vm_size = "Standard_D2ds_v5"
max_pods = 110

# path to kubeconfig file
filename = <path-to-kubeconfig-file>

