provider "azurerm" {
  features = {}

  client_id       = jsondecode(base64decode(var.azure_credentials)).clientId
  client_secret   = jsondecode(base64decode(var.azure_credentials)).clientSecret
  tenant_id       = jsondecode(base64decode(var.azure_credentials)).tenantId
  subscription_id = jsondecode(base64decode(var.azure_credentials)).subscriptionId
}

variable "azure_credentials" {
  type        = string
  description = "Base64 encoded Azure credentials JSON"
}
