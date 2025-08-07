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
