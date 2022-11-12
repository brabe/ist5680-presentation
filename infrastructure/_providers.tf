
terraform {
  backend "azurerm" {
    // deployed via backend_<env>.tfvars
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "b9c0d86b-4e0c-492a-a376-558d9ced5a85"
}
