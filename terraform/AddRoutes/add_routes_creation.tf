#Provider - Microsoft Azure
#Terraform Template to add multiple routes
#Organization - HCL Technologies
#File Name - add_routes_creation.tf
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

data "azurerm_firewall" "firewall" {
    count = length(var.FirewallName)
  name                = var.FirewallName[count.index]
  resource_group_name = var.FirewallResourceGroup[count.index]
}

resource "azurerm_route" "addRoute" {
    count = length(var.RouteName)
  name                   = var.RouteName[count.index]
  resource_group_name    = var.RouteTableResourceGroup[count.index]
  route_table_name       = var.RouteTableName[count.index]
  address_prefix         = var.AddressPrefix[count.index]
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = data.azurerm_firewall.firewall[count.index].ip_configuration[0].private_ip_address
}

#END OF FILE