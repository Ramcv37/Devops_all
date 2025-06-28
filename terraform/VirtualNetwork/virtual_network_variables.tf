#Provider - Microsoft Azure
#This file contain virtual network variables in List format
#Organization - HCL Technologies
#File Name - virtual_network_variables.tf
#File version - 1.0

variable "VirtualNetworkName" {
    type = list(string)
    description = "Virtual Network Name"
}

variable "VirtualNetworkLocation" {
    type = list(string)
    description = "Virtual Network Location"
}

variable "VirtualNetworkResourceGroup" {
    type = list(string)
    description = "Virtual Network Resource Group Name"
}

variable "AddressSpace" {
    type = list(string)
    description = "Virtual Network Address Space"
}

#END OF FILE