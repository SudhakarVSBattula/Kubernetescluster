terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "tfstaterg0014"
        storage_account_name = "tfstatestr0014"
        container_name       = "tfstatecontainer"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
}