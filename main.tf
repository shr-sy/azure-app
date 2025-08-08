# Generate a random suffix to keep names unique
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-app-apim-01"
  location = "Central India"
}

# App Service Plan
resource "azurerm_service_plan" "plan" {
  name                = "app-service-plan-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Linux Web App
resource "azurerm_linux_web_app" "app" {
  name                = "my-app-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}

# API Management Service
resource "azurerm_api_management" "apim" {
  name                = "my-apim-demo-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Demo Publisher"
  publisher_email     = "demo@example.com"
  sku_name            = "Developer_1"
}

# API Management API
resource "azurerm_api_management_api" "api" {
  name                = "demo-api-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Demo API"
  path                = "demo"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v2.0/json/petstore-simple.json"
  }
}
