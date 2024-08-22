output "resource_group_name" {
  value = "${var.name}-${var.environment}-rg"
}

output "aks_name" {
  value = "${var.name}-${var.environment}-aks"
}

output "kubeconfig_path" {
  value = abspath("${path.root}/kubeconfig")
}

