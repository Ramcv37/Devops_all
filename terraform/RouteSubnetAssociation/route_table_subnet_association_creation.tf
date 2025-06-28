#Provider - Microsoft Azure
#Terraform Template to create subnet and route table association
#Organization - HCL Technologies
#File Name - route_table_subnet_association_creation.tf
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

resource "azurerm_subnet_route_table_association" "routeSubnetAssociation" {
    count = length(var.SubnetId)
  subnet_id      = var.SubnetId[count.index]
  route_table_id = var.RouteTableId[count.index]
}

#END OF FILE