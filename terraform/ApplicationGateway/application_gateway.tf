#Provider - Microsoft Azure
#Terraform Template to create Application gateway
#Organization - HCL Technologies
#File Name - application_gateway.tf
#File version - 1.0

#Terraform
terraform {
  required_version = "0.14.11"
  #  required_version= "1.0.6"
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

#resource declaration: 

data "azurerm_subnet" "GatewaySubnet" {
  count                = length(var.SubnetRGName)
  name                 = var.SubnetName[count.index]
  resource_group_name  = var.SubnetRGName[count.index]
  virtual_network_name = var.VnetName[count.index]
}

resource "azurerm_public_ip" "publicip" {
  count               = length(var.PublicIPName)
  name                = var.PublicIPName[count.index]
  resource_group_name = var.ResourceGroupName[count.index]
  location            = var.Location[count.index]
  //allocation_method   = "Dynamic"
  allocation_method   = "Static"
  sku = "Standard"
}




resource "azurerm_application_gateway" "ag" {
  count               = length(var.AppGatewayName)
  name                = var.AppGatewayName[count.index]
  resource_group_name = var.ResourceGroupName[count.index]
  location            = var.Location[count.index]

sku {
    name     = "Standard_v2"
    tier     = "Standard_v2" 
    capacity = 1
  }

  #&nbsp;since these variables are re-used - a locals block makes this more maintainable
##offload these to PS.
#  locals {
#    backend_address_pool_name      = "${var.AppGatewayName[count.index]}-beap"
#    frontend_port_name             = "${var.AppGatewayName[count.index]}-feport"
#    frontend_ip_configuration_name = "${var.AppGatewayName[count.index]}-feip"
#    http_setting_name              = "${var.AppGatewayName[count.index]}-be-htst"
#    listener_name                  = "${var.AppGatewayName[count.index]}-httplstn"
#    request_routing_rule_name      = "${var.AppGatewayName[count.index]}-rqrt"
#    redirect_configuration_name    = "${var.AppGatewayName[count.index]}-rdrcfg"
 # }


  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.GatewaySubnet[count.index].id
  }

  frontend_port {
#    name = local.frontend_port_name
    name = "app-gw-frontend-port"
    port = 80
  }

  frontend_ip_configuration {
#    name                 = local.frontend_ip_configuration_name
    name = "app-gw-frontend-ipconfig"
    public_ip_address_id = azurerm_public_ip.publicip[count.index].id
  }

  backend_address_pool {
    name = "app-gw-backend-apool"
  }

  backend_http_settings {
    name                  = "app-gw-http-setting"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "app-gw-listener"
    frontend_ip_configuration_name = "app-gw-frontend-ipconfig"
    frontend_port_name             = "app-gw-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
   name                       = "app-gw-RR-rule"
  #  name = var.AppGatewayName[count.index]-rule
    rule_type                  = "Basic"
    http_listener_name         = "app-gw-listener"
    backend_address_pool_name  = "app-gw-backend-apool"
    backend_http_settings_name = "app-gw-http-setting"
  }
}

#tf import block

