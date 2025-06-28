#Provider - Microsoft Azure
#This file contain  Azure front door variables in List format
#Organization - HCL Technologies
#File Name - AzureFrontDoor_variables.tf
#File version - 1.0

variable "FrontendEndpointName" {
    type = list(string)
    description = "FrontendEndpoint"
}

variable "ResourceGroupName" {
    type = list(string)
    description = "FrontdoorResourceGroup"
}

variable "RoutingRuleName" {
    type = list(string)
    description = "RoutingRuleName"
}
variable "HostHeader" {
    type = list(string)
    description = "HostHeader"
}
variable "Address" {
    type = list(string)
    description = "Address"
}

