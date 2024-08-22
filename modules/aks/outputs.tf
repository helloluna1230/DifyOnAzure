output "aks_name" {
    value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  description = "kubeconfig for kubectl access."
  sensitive   = true
}

output "fqdn" {
    value = azurerm_kubernetes_cluster.aks.fqdn
}

