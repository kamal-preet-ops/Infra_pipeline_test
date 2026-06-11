terraform {
  backend "azurerm" {
     resource_group_name = "rg-test-1" 
      storage_account_name = "terraformkamalstorage"
      container_name = "codecontainer"
      key = "pracctice.tfstate"

  }
  required_providers {
    azurerm ={
        source = "Hashicorp/azurerm"
        version = "4.73.0"
    }
  }
}

provider "azurerm" {
    features {}
  
  
}