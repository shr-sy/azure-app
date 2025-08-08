terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}

  client_id       = jsondecode(var.azure_credentials).clientId
  client_secret   = jsondecode(var.azure_credentials).clientSecret
  tenant_id       = jsondecode(var.azure_credentials).tenantId
  subscription_id = jsondecode(var.azure_credentials).subscriptionId
}

variable "azure_credentials" {
  description = "Azure credentials JSON stored in GitHub Secrets"
  type        = string
}
