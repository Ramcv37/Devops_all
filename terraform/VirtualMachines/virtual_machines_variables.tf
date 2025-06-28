#Provider - Microsoft Azure
#This file contain virtual machines variables in List format
#Organization - HCL Technologies
#File Name - virtual_machines_variables.tf
#File version - 1.0

variable "VirtualMachineName" {
    type = list(string)
    description = "Name of the Virtual machine"
}

variable "ExistingResourceGroupName" {
    type = list(string)
    description = "Existing Resource Group Name for Virtual Machine"
}

variable "Location" {
    type = list(string)
    description = "Virtual Machine Location"
}

variable "VMSize" {
    type = list(string)
    description = "Virtual Machine Size"
}

variable "ComputerName" {
    type = list(string)
    description = "HostName of VM - only 15 characters limit"
}

variable "UserName" {
    type = list(string)
    description = "Admin UserName for Virtual Machine"
}

variable "Password" {
    type = list(string)
    description = "Password for Virtual Machine"
}

variable "NetworkInterfaceName" {
    type = list(string)
    description = "Name of the Network Interface"
}

variable "NetworkInterfaceResourceGroup" {
    type = list(string)
    description = "Resource Group of Nerwork Interface"
}

variable "OSCaching" {
    type = list(string)
    description = "OS caching details - None, ReadOnly, ReadWrite supported"
}

variable "StorageAccountType" {
    type = list(string)
    description = "Type of storage account - StandardLRS, StandardSSD_LRS, Premium_LRS Supported"
}

variable "Publisher" {
    type = list(string)
    description = "Azure Marketplace image publisher details"
}

variable "offer" {
    type = list(string)
    description = "Azure Marketplace image offer details"
}

variable "sku" {
    type = list(string)
    description = "Azure Marketplace image sku details"
}

variable "Latestversion" {
    type = list(string)
    description = "Azure Marketplace image version details"
}
# END OF FILE