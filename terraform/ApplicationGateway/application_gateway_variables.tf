


variable "ResourceGroupName" {
    type = list(string)
    description = "Name of the Resource Group"
}

variable "VnetName" {
    type = list(string)
    description = "Name of the Vnet"
}

variable "Location" {
    type = list(string)
    description = "Location"
}

variable "PublicIPName" {
    type = list(string)
    description = "Name of the PublicIP"
}
##this is not needed
variable "AppGatewayName" {
    type = list(string)
    description = "Please provide Application gateway name"
}

variable "SubnetRGName" {
    type = list(string)
    description = "Please provide gateway subnet resource group name"
}

variable "SubnetName" {
    type = list(string)
    description = "Please provide gateway subnet resource group name"
    default = [ "ApplicationGatewaySubnet" ]
}
