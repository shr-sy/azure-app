resource "azurerm_resource_group" "rg" {
  name     = "rg-app-apim"
  location = "Central India"
}

resource "azurerm_service_plan" "plan" {
  name                = "app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_app_service" "app" {
  name                = "my-app-service-123"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.plan.id

  site_config {
    linux_fx_version = "NODE|18-lts"
  }
}

resource "azurerm_api_management" "apim" {
  name                = "my-apim-demo-123"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Example Publisher"
  publisher_email     = "publisher@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "api" {
  name                = "demo-api"
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
