<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	22 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	network_interfaces_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create network interfaces input variable file.

    .INPUTS
        This script required excel file which contain NetworkInterfaces worksheet details.
        
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
[string]$excel_worksheet_name = "NetworkInterfaces"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "NetworkInterfaces" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Virtual Network Name'))`
     -or ([string]::IsNullOrEmpty($data.'VNET Resource Group'))`
      -or ([string]::IsNullOrEmpty($data.'Subnet Name'))`
       -or ([string]::IsNullOrEmpty($data.'Network Interface Name'))`
        -or ([string]::IsNullOrEmpty($data.'Location'))`
         -or ([string]::IsNullOrEmpty($data.'Public IP Name'))`
          -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
           -or ([string]::IsNullOrEmpty($data.'Allocation Method'))`
            -or ([string]::IsNullOrEmpty($data.'Sku'))`
             -or ([string]::IsNullOrEmpty($data.'IP Configuration Name'))`
              -or ([string]::IsNullOrEmpty($data.'Private IP Allocation')))

    {
        break
    }

    $vnet_name                += '"' + (($data.'Existing Virtual Network Name').Trim()) + '"' + ','
    $vnet_resource_group      += '"' + (($data.'VNET Resource Group').Trim()) + '"' + ','
    $subnet                   += '"' + (($data.'Subnet Name').Trim()) + '"' + ','
    $network_interface        += '"' + ($data.'Network Interface Name') + '"' + ','
    $location                 += '"' + ($data.'Location') + '"' + ','
    $public_IP_name           += '"' + (($data.'Public IP Name').Trim()) + '"' + ','
    $resource_group           += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $allocation_method        += '"' + (($data.'Allocation Method').Trim()) + '"' + ','
    $sku                      += '"' + (($data.'Sku').Trim()) + '"' + ','
    $ip_configuration         += '"' + ($data.'IP Configuration Name') + '"' + ','
    $private_ip_allocation    += '"' + ($data.'Private IP Allocation') + '"' + ','
}

if (($vnet_name -eq $null) -or ($vnet_resource_group -eq $null)`
     -or ($subnet -eq $null) -or ($network_interface -eq $null)`
     -or ($location -eq $null) -or ($public_IP_name -eq $null)`
      -or ($allocation_method -eq $null)`
       -or ($sku -eq $null) -or ($resource_group -eq $null)`
     -or ($ip_configuration -eq $null) -or ($private_ip_allocation -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $vnet_name              = $vnet_name.TrimEnd(',')
    $vnet_resource_group    = $vnet_resource_group.TrimEnd(',')
    $subnet                 = $subnet.TrimEnd(',')
    $network_interface      = $network_interface.TrimEnd(',')
    $location               = $location.TrimEnd(',')
    $public_IP_name         = $public_IP_name.TrimEnd(',')
    $allocation_method      = $allocation_method.TrimEnd(',')
    $sku                    = $sku.TrimEnd(',')
    $resource_group         = $resource_group.TrimEnd(',')
    $ip_configuration       = $ip_configuration.TrimEnd(',')
    $private_ip_allocation  = $private_ip_allocation.TrimEnd(',')

$variable_creation = @"
VirtualNetworkName    = [$vnet_name]
VNETResourceGroup     = [$vnet_resource_group]
SubnetName            = [$subnet]
NetworkInterfaceName  = [$network_interface]
Location              = [$location]
PublicIPName          = [$public_IP_name]
AllocationMethod      = [$allocation_method]
sku                   = [$sku]
ExistingResourceGroup = [$resource_group]
IPConfigurationName   = [$ip_configuration]
PrivateIPAllocation   = [$private_ip_allocation]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################