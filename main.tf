provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name = "Abilash-Rg"
}

resource "azurerm_app_service_plan" "Abhilash-plan" {
  name                = "Abhilash-appservice-plan"
  location            = "East US"
  resource_group_name = data.azurerm_resource_group.example.name
  kind                = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
  reserved = true
}

resource "azurerm_app_service" "example" {
  name                = "ttltest-appservice"
  location            = "East US"
  resource_group_name = data.azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.Abhilash-plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "10.14.1"
  }
}
