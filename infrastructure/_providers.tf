
terraform {
  backend "azurerm" {
    subscription_id      = "b9c0d86b-4e0c-492a-a376-558d9ced5a85"
    container_name       = "tfdemo"
    storage_account_name = "gtstfstate"
    resource_group_name  = "tf-storage"
    key                  = "mad_ist5680"
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
