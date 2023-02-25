terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "terraformstateresource"
        storage_account_name = "tfsastate"
        container_name       = "tfsacontainer"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
}