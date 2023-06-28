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
  subscription_id = "d9a192ef-ddee-4dc1-842d-7120ef438c6f"
  client_id       = "b4724084-8614-467d-824e-6bd9471798ac"
  client_secret   = "tTV8Q~yKd5idYpa5kAXVEORUngEooFzU2A.JkcKm"
  tenant_id       = "e9d05cce-27dc-432d-92ce-0642b8c0d745"
}


