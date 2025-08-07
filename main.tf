resource "azurerm_resource_group" "rg" {
  name     = "rg-demo-policy"
  location = "Central India"
}

resource "azurerm_service_plan" "plan" {
  name                = "plan-demo-policy"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_app_service" "app" {
  name                = "app-policy-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.plan.id
}

resource "azurerm_api_management" "apim" {
  name                = "demo-apim-instance"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Demo Publisher"
  publisher_email     = "demo@example.com"
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
    content_value  = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v2.0/json/petstore-expanded.json"
  }
}

resource "azurerm_api_management_api_policy" "api_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.rg.name
  xml_content         = file("${path.module}/policy.xml")
}
