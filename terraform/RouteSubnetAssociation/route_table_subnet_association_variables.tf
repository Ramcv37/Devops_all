#Provider - Microsoft Azure
#This file contain subnet and route table association Variables in List format
#Organization - HCL Technologies
#File Name - route_table_subnet_association_variables.tf
#File version - 1.0

variable "SubnetId" {
    type = list(string)
    description = "subnet ID"
}

variable "RouteTableId" {
    type = list(string)
    description = "Route Table ID"
}

#End of File