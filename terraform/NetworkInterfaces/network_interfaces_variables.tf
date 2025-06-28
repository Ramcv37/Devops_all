#Provider - Microsoft Azure
#This file contain Network Interfaces variables in List format
#Organization - HCL Technologies
#File Name - network_interfaces_variables.tf
#File version - 1.0

variable "VirtualNetworkName" {
    type = list(string)
    description = "Existing Virtual Network Name"
}

variable "VNETResourceGroup" {
    type = list(string)
    description = "Virtual Network Resource Group Name"
}

variable "SubnetName" {
    type = list(string)
    description = "Existing Subnet Name"
}

variable "NetworkInterfaceName" {
    type = list(string)
    description = "New Name for Network Interface"
}

variable "Location" {
    type = list(string)
    description = "Network Interface Location"
}

variable "ExistingResourceGroup" {
    type = list(string)
    description = "Existing Resource Group Name for Network Interface"
}

variable "IPConfigurationName" {
    type = list(string)
    description = "Name for IP Configuration for example - ipconfig1"
}

variable "PrivateIPAllocation" {
    type = list(string)
    description = "IP address allocation method - only dynamic supported"
}

variable "PublicIPName" {
    type = list(string)
    description = "Public IP Name"
}

variable "AllocationMethod" {
    type = list(string)
    description = "Public IP Allocation Method - Static & Dynamic Supported"
}

variable "sku" {
    type = list(string)
    description = "Standard and Basic value supported"
}
# END OF FILE