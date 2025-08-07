resource "azurerm_resource_group" "rg" {
  name     = "rg-demo-policy"
  location = "Central India"
}

resource "azurerm_app_service_plan" "plan" {
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
  app_service_plan_id = azurerm_app_service_plan.plan.id
}
