terraform {
  required_providers {
    azurerm ={
        source = "Hashicorp/azurerm"
        version = "4.73.0"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = "d1628de0-f424-48b6-b5f9-194ee0354cad"
  
}