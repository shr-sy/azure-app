resource "azurerm_resource_group" "rg" {
  name     = "rg-demo-policy"
  location = "Central India"
}

resource "azurerm_service_plan" "plan" {
  name                = "plan-demo-policy"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "app-policy-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
}

resource "azurerm_api_management" "apim" {
  name                = "demo-apim-instance-new"  # changed to avoid 409 conflict
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "Demo Publisher"
  publisher_email     = "demo@example.com"
  sku_name            = "Developer_1"
}
