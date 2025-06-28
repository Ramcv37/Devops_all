variable "name" {
    type = string
    description = "Public IP Name"
}

variable "allocation_method" {
    type = string
    description = "Public IP Allocation Method - Static & Dynamic Supported"
}

variable "sku" {
    type = string
    description = "Standard and Basic value supported"
}

variable "location" {
    type = string
    description = "Network Interface Location"
}

variable "resource_group_name" {
    type = string
    description = "Existing Resource Group Name for Network Interface"
}