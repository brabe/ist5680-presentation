
locals {
  prefix = "ist5680_${var.environment}"
}

resource "azurerm_resource_group" "rg01" {
  name     = "${local.prefix}-rg01"
  location = "centralus"
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
      docker_image     = var.docker_image
      docker_image_tag = var.docker_image_tag
    }
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://index.docker.io/v1"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.docker_server_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.docker_server_password
  }

  identity {
    type = "SystemAssigned"
  }
}
