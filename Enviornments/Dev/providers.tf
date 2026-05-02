terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" { }
}


provider "azurerm" {
  features {}
  subscription_id = "68091150-801e-4498-8be2-e5d4bcf9919c"

}