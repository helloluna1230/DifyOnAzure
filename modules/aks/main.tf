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

  # Assign Network Contributor role to the AKS service principal for the Application Gateway subnet.
  resource "azurerm_role_assignment" "aks_appgw_subnet" {
    principal_id   = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
    role_definition_name = "Network Contributor"
    scope          = var.vnet_id
  }