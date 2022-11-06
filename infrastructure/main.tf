
locals {
  prefix = "mad-ist5680"
}

resource "azurerm_resource_group" "rg01" {
  name     = local.prefix
  location = "Central US"
}


resource "azurerm_service_plan" "asp01" {
  name                = "${local.prefix}-asp01"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "web01" {
  name                = "${local.prefix}-web01"
  resource_group_name = azurerm_resource_group.rg01.name
  location            = azurerm_resource_group.rg01.location
  service_plan_id     = azurerm_service_plan.asp01.id

  site_config {
    application_stack {
      docker_image = "nginx"
      docker_image_tag = "latest"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
