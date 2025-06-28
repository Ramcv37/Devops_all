#Provider - Microsoft Azure
#This file contain Bastion host variables in List format
#Organization - HCL Technologies
#File Name - bastion_variables.tf
#File version - 1.0

variable "VirtualNetworkName" {
    type = list(string)
    description = "Existing Virtual Network Name"
}

variable "VNETResourceGroup" {
    type = list(string)
    description = "Existing Virtual Network Resource Group Name"
}

variable "Subnet" {
    type = list(string)
    description = "Subnet Name - AzureBastionSubnet"
}

variable "PublicIPName" {
    type = list(string)
    description = "Public IP Name"
}

variable "ExistingResourceGroupName" {
    type = list(string)
    description = "Existing Resource Group Name for Public IP"
}

variable "AllocationMethod" {
    type = list(string)
    description = "Public IP Allocation Method - Static & Dynamic Supported"
}

variable "sku" {
    type = list(string)
    description = "Standard and Basic value supported"
}

variable "BastionHostName" {
    type = list(string)
    description = "Name for the Bastion host"
}

variable "Location" {
    type = list(string)
    description = "Location for Bastion Host"
}

variable "IPConfigurationName" {
    type = list(string)
    description = "IP Configuration Name"
}
# END OF FILE