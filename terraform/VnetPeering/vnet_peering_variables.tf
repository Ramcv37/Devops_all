#Provider - Microsoft Azure
#This file contain VNet Peering variables in List format
#Organization - HCL Technologies
#File Name - vnet_peering_variables.tf
#File version - 1.0

variable "PeeringName" {
    type = list(string)
    description = "Virtual Network Peering Name"
}

variable "LocalVnetResourceGroup" {
    type = list(string)
    description = "Local Virtual Network Resource Group Name"
}

variable "LocalVNet" {
    type = list(string)
    description = "Local Virtual Network Name"
}

variable "RemoteVnetID" {
    type = list(string)
    description = "Remote Virtual Network ID"
}

#END OF FILE