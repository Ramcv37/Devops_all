#Provider - Microsoft Azure
#This file contain 'add routes' details in list format
#Organization - HCL Technologies
#File Name - add_routes_variables.tf
#File version - 1.0

variable "RouteName" {
    type = list(string)
    description = "Name of the Route"
}

variable "RouteTableName" {
    type = list(string)
    description = "Existing Route Table Name"
}

variable "RouteTableResourceGroup" {
    type = list(string)
    description = "Existing Route Table Resource Group Name"
}

variable "AddressPrefix" {
    type = list(string)
    description = "Route Address Prefix"
}

variable "FirewallName" {
    type = list(string)
    description = "Existing Firewall Name"
}

variable "FirewallResourceGroup" {
    type = list(string)
    description = "Existing Firewall Resource Group"
}

# END OF FILE