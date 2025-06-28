<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	21 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	virtual_machines_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create Virtual Machines input variable file.

    .INPUTS
        This script required excel file which contain VirtualMachines worksheet details.
        
    .NOTES
        This script required module as mentioned below
        Import-Excel PowerShell Module (Latest)

    .LINK
        Below are the link to download Required PowerShell Module
        https://www.powershellgallery.com/packages/ImportExcel/7.1.1
#>

$ErrorActionPreference = 'Stop'

#region importing module
Install-Module Importexcel -force
Import-Module ImportExcel -verbose
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "VirtualMachines"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "VirtualMachines" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Virtual Machine Name'))`
     -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
      -or ([string]::IsNullOrEmpty($data.Location))`
       -or ([string]::IsNullOrEmpty($data.'VM Size'))`
        -or ([string]::IsNullOrEmpty($data.'Computer Name'))`
         -or ([string]::IsNullOrEmpty($data.UserName))`
          -or ([string]::IsNullOrEmpty($data.Password))`
           -or ([string]::IsNullOrEmpty($data.'Network Interface Name'))`
            -or ([string]::IsNullOrEmpty($data.'Network Interface Resource Group'))`
             -or ([string]::IsNullOrEmpty($data.'OS Disk Caching'))`
              -or ([string]::IsNullOrEmpty($data.'Storage Account Type'))`
               -or ([string]::IsNullOrEmpty($data.Publisher))`
                -or ([string]::IsNullOrEmpty($data.Offer))`
                 -or ([string]::IsNullOrEmpty($data.Sku))`
                  -or ([string]::IsNullOrEmpty($data.Version)))

    {
        break
    }

    $virtual_machine                     += '"' + (($data.'Virtual Machine Name').Trim()) + '"' + ','
    $resource_group                      += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $location                            += '"' + (($data.Location).Trim()) + '"' + ','
    $vm_size                             += '"' + (($data.'VM Size').Trim()) + '"' + ','
    $computer_name                       += '"' + (($data.'Computer Name').Trim()) + '"' + ','
    $username                            += '"' + (($data.UserName).Trim()) + '"' + ','
    $password                            += '"' + (($data.Password).Trim()) + '"' + ','
    $network_interface                   += '"' + (($data.'Network Interface Name').Trim()) + '"' + ','
    $network_interface_resource_group    += '"' + (($data.'Network Interface Resource Group').Trim()) + '"' + ','
    $os_disk_caching                     += '"' + (($data.'OS Disk Caching').Trim()) + '"' + ','
    $storage_account_type                += '"' + (($data.'Storage Account Type').Trim()) + '"' + ','
    $publisher                           += '"' + (($data.Publisher).Trim()) + '"' + ','
    $offer                               += '"' + (($data.Offer).Trim()) + '"' + ','
    $sku                                 += '"' + (($data.Sku).Trim()) + '"' + ','
    $version                             += '"' + (($data.Version).Trim()) + '"' + ','
}

if (($virtual_machine -eq $null) -or ($resource_group -eq $null) -or ($computer_name -eq $null)`
     -or ($location -eq $null) -or ($vm_size -eq $null)`
      -or ($username -eq $null) -or ($password -eq $null)`
       -or ($network_interface -eq $null) -or ($network_interface_resource_group -eq $null)`
        -or ($os_disk_caching -eq $null) -or ($storage_account_type -eq $null)`
         -or ($publisher -eq $null) -or ($offer -eq $null)`
          -or ($sku -eq $null) -or ($version -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $virtual_machine                  = $virtual_machine.TrimEnd(',')
    $resource_group                   = $resource_group.TrimEnd(',')
    $location                         = $location.TrimEnd(',')
    $vm_size                          = $vm_size.TrimEnd(',')
    $computer_name                    = $computer_name.TrimEnd(',')
    $username                         = $username.TrimEnd(',')
    $password                         = $password.TrimEnd(',')
    $network_interface                = $network_interface.TrimEnd(',')
    $network_interface_resource_group = $network_interface_resource_group.TrimEnd(',')
    $os_disk_caching                  = $os_disk_caching.TrimEnd(',')
    $storage_account_type             = $storage_account_type.TrimEnd(',')
    $publisher                        = $publisher.TrimEnd(',')
    $offer                            = $offer.TrimEnd(',')
    $sku                              = $sku.TrimEnd(',')
    $version                          = $version.TrimEnd(',')


$variable_creation = @"
VirtualMachineName            = [$virtual_machine]
ExistingResourceGroupName     = [$resource_group]
Location                      = [$location]
VMSize                        = [$vm_size]
ComputerName                  = [$computer_name]
UserName                      = [$username]
Password                      = [$password]
NetworkInterfaceName          = [$network_interface]
NetworkInterfaceResourceGroup = [$network_interface_resource_group]
OSCaching                     = [$os_disk_caching]
StorageAccountType            = [$storage_account_type]
Publisher                     = [$publisher]
offer                         = [$offer]
sku                           = [$sku]
Latestversion                 = [$version]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################