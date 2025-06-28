#Provider - Microsoft Azure
#Terraform Template to enable Azure Front Door
#Organization - HCL Technologies
#File Name - AzureFrontDoor_creation.tf
#File version - 1.0

#Terraform
#azure storage account backend provided to store terraform state file using release pipeline
terraform {
  required_version= "1.0.8"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.80.0"
    }
  }
  backend "azurerm" {
  }
}
#Azure provider
provider "azurerm" {
  features{}
}

# Create front door
resource "azurerm_frontdoor" "FrontDoor" {
  count                                        = length(var.FrontendEndpointName)
  name                                         = var.FrontendEndpointName[count.index]
  resource_group_name                          = var.ResourceGroupName[count.index]
  enforce_backend_pools_certificate_name_check = false


  routing_rule {
    name                      = var.RoutingRuleName[count.index]
    accepted_protocols        = ["Http", "Https"]
    patterns_to_match         = ["/*"]
    frontend_endpoints        = [var.FrontendEndpointName][count.index]
    forwarding_configuration {
      forwarding_protocol     = "MatchRequest"
      backend_pool_name       = "fd-backend-pool"
    }
  }     
  backend_pool_load_balancing {
     name = "fd-bepool-loadbalancer"
  }

 backend_pool_health_probe {
    name = "fd-bepool-healthprobe"
    }

  backend_pool {
        name                = "fd-backend-pool"
        load_balancing_name = "fd-bepool-loadbalancer"
        health_probe_name   = "fd-bepool-healthprobe"
    backend {
          enabled = true
          host_header = var.HostHeader[count.index]
          address     = var.Address[count.index]
          http_port   = 80
          https_port  = 443
          priority = 1
          weight = 50
        }
      }


  frontend_endpoint {
    name      = var.FrontendEndpointName[count.index]
    host_name = "${var.FrontendEndpointName[count.index]}.azurefd.net"
  }
}