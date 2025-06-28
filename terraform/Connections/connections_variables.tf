#Provider - Microsoft Azure
#This file contain Azure Connections Variables in List format
#Organization - HCL Technologies
#File Name - connections_variables.tf
#File version - 1.0

variable "ResourceGroupName" {
    type        = list(string)
    description = "Resource Group Name"
}

variable "ResourceGroupLocation" {
    type        = list(string)
    description = "Resource Group Location"
}

variable "ConnectionName" {
    type = list(string)
    description = "VPN gateway and Local network gateway connection name"
}

variable "VPNGatewayID" {
    type = list(string)
    description = "VPN Gateway Resource ID"
}

variable "LocalNetworkgatewayID" {
    type = list(string)
    description = "Local network gateway resource ID"
}

variable "SharedKey" {
    type = list(string)
    description = "Shared Key"
}

#End of File