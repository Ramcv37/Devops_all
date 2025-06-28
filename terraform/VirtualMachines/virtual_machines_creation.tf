#Provider - Microsoft Azure
#Terraform Template to create multiple Virtual Machines
#Organization - HCL Technologies
#File Name - virtual_machines_creation.tf
#File version - 1.0

#Terraform
terraform {
    // required_version = "1.2.4"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "3.0.0"
        }
    }
  backend "azurerm" {
    }
}

#Azure provider
provider "azurerm" {
    features {}
}

data "azurerm_network_interface" "networkInterface" {
    count = length(var.NetworkInterfaceName)
  name                = var.NetworkInterfaceName[count.index]
  resource_group_name = var.NetworkInterfaceResourceGroup[count.index]
}

resource "azurerm_windows_virtual_machine" "virtualMachine" {
    count = length(var.VirtualMachineName)
  name                = var.VirtualMachineName[count.index]
  resource_group_name = var.ExistingResourceGroupName[count.index]
  location            = var.Location[count.index]
  size                = var.VMSize[count.index]
  computer_name       = var.ComputerName[count.index]
  admin_username      = var.UserName[count.index]
  admin_password      = var.Password[count.index]
  network_interface_ids = [
    data.azurerm_network_interface.networkInterface[count.index].id,
  ]

  os_disk {
    caching              = var.OSCaching[count.index]
    storage_account_type = var.StorageAccountType[count.index]
  }

  source_image_reference {
    publisher = var.Publisher[count.index]
    offer     = var.offer[count.index]
    sku       = var.sku[count.index]
    version   = var.Latestversion[count.index]
  }
}
#END OF FILE