#Provider - Microsoft Azure
#This file contain subnet variables in List format
#Organization - HCL Technologies
#File Name - subnets_variables.tf
#File version - 1.0

variable "VirtualNetworkName" {
    type = list(string)
    description = "Virtual Network Name"
}

variable "SubnetName" {
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

variable "enforce_pep" {
    type = list(bool)
    description = " In order to deploy a Private Link Endpoint on a given subnet, you must set the enforce_private_link_endpoint_network_policies attribute to true"
}

variable "enforce_private_link_service" {
    type = list(bool)
    description = "In order to deploy a Private Link Service on a given subnet, you must set the enforce_private_link_service_network_policies attribute to true"
}

#END OF FILE