terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }


   backend "azurerm" {
     resource_group_name  = "tfstate_rg"
     storage_account_name = "tfstatesa1761538754"
     container_name       = "cla-proj-tfstate"
     key                  = "terraform.tfstate"
   }
}


provider "azurerm" {
  features {}
  subscription_id = "XXXXXXXXXXXXXXXXXX"
  client_id       = "XXXXXXXXXXXXXXXXXX"
  client_secret   = "XXXXXXXXXXXXXXXXXX"
  tenant_id       = "XXXXXXXXXXXXXXXXXX"
}


