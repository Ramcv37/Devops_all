#Provider - Microsoft Azure
#Terraform Template to create VPN Gateway
#Organization - HCL Technologies
#File Name - vpn_gateway_creation.tf
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

data "azurerm_subnet" "subnet" {
    count = length(var.SubnetName)
  name                 = var.SubnetName[count.index]
  virtual_network_name = var.VirtualNetworkName[count.index]
  resource_group_name  = var.ResourceGroupName[count.index]
}

resource "azurerm_public_ip" "publicIP" {
    count = length(var.PublicIPName)
  name                = var.PublicIPName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroupName[count.index]
  allocation_method   = var.AllocationMethod[count.index]
}

resource "azurerm_virtual_network_gateway" "vpnGateway" {
    count = length(var.VNETGatewayName)
  name                = var.VNETGatewayName[count.index]
  location            = var.Location[count.index]
  resource_group_name = var.ResourceGroupName[count.index]

  type     = var.GatewayType[count.index]
  vpn_type = var.VPNType[count.index]

  active_active = false
  enable_bgp    = false
  sku           = var.sku[count.index]

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.publicIP[count.index].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnet[count.index].id
  }
}

#END OF FILE