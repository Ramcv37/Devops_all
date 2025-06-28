#Provider - Microsoft Azure
#Terraform Template to create multiple route table
#Organization - HCL Technologies
#File Name - route_table_creation.tf
#File version - 1.0

#Terraform
terraform {
  required_version = "0.14.11"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
     }
  }
    backend "azurerm" {
  }
}

#Azure provider
provider "azurerm" {
  features {}
}

resource "azurerm_route_table" "routeTable" {
    count = length(var.RouteTableName)
  name                = var.RouteTableName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroup[count.index]
}

#END OF FILE