#================================================================================================
# Provider Configuration
#================================================================================================

terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "random" {}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  subscription_id            = var.sp-subscription-id
  client_id                  = var.sp-client-id
  client_secret              = var.sp-client-secret
  tenant_id                  = var.sp-tenant-id
}
