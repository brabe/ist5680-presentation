
locals {
  prefix = var.prefix
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
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      site_config[0].application_stack[0],
      app_settings["DOCKER_REGISTRY_SERVER_URL"]
    ]
  }
}

resource "azurerm_linux_web_app_slot" "preview" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.web01.id
  site_config {
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "latest"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      site_config[0].application_stack[0],
      app_settings["DOCKER_REGISTRY_SERVER_URL"]
    ]
  }

}
