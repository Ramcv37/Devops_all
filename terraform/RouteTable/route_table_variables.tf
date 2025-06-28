#Provider - Microsoft Azure
#This file contain route table details List format
#Organization - HCL Technologies
#File Name - route_table_variables.tf
#File version - 1.0

variable "RouteTableName" {
    type = list(string)
    description = "Name of the Route Table"
}

variable "ResourceGroup" {
    type = list(string)
    description = "Name of the route table resource group"
}

variable "Location" {
    type = list(string)
    description = "Location of Route Table"
}

# END OF FILE