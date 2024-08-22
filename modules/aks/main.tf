# Create the aks cluster.
resource "azurerm_kubernetes_cluster" "aks" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.aks_name
  dns_prefix          = "${var.aks_name}-dns"
  kubernetes_version  = var.kubernetes_version

  # Set the default node pool config.
  default_node_pool {
    name           = "default"
    node_count      = var.node_count
    vm_size         = var.vm_size
    max_pods        = var.max_pods
    vnet_subnet_id = var.subnet_aks # Nodes and pods will receive ip's from here.
  }

  # Set the identity profile.
  identity {
    type = "SystemAssigned"
  }

  # Set the network profile.
  network_profile {
    network_plugin = "azure"
  }
  ingress_application_gateway {
        gateway_name = var.appgw_name
        subnet_id    = var.subnet_appgw
  }

}