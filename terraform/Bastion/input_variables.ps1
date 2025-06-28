<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	24 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	bastion_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create Bastion input variable file.

    .INPUTS
        This script required excel file which contain Bastion worksheet details.
        
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
[string]$excel_worksheet_name = "Bastion"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "Bastion" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Virtual Network Name'))`
     -or ([string]::IsNullOrEmpty($data.'VNET Resource Group'))`
      -or ([string]::IsNullOrEmpty($data.'Existing Subnet Name'))`
       -or ([string]::IsNullOrEmpty($data.'Public IP Name'))`
        -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
         -or ([string]::IsNullOrEmpty($data.'Allocation Method'))`
          -or ([string]::IsNullOrEmpty($data.Sku))`
           -or ([string]::IsNullOrEmpty($data.'Bastion Host Name'))`
            -or ([string]::IsNullOrEmpty($data.Location))`
             -or ([string]::IsNullOrEmpty($data.'IP Configuration Name')))

    {
        break
    }

    $virtual_network_name     += '"' + (($data.'Existing Virtual Network Name').Trim()) + '"' + ','
    $VNET_resource_group      += '"' + (($data.'VNET Resource Group').Trim()) + '"' + ','
    $subnet_name              += '"' + (($data.'Existing Subnet Name').Trim()) + '"' + ','
    $public_IP_name           += '"' + (($data.'Public IP Name').Trim()) + '"' + ','
    $resource_group           += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $allocation_method        += '"' + (($data.'Allocation Method').Trim()) + '"' + ','
    $sku                      += '"' + (($data.Sku).Trim()) + '"' + ','
    $bastion_host_name        += '"' + (($data.'Bastion Host Name').Trim()) + '"' + ','
    $location                 += '"' + (($data.Location).Trim()) + '"' + ','
    $ip_configuration_name    += '"' + (($data.'IP Configuration Name').Trim()) + '"' + ','
}

if (($virtual_network_name -eq $null) -or ($VNET_resource_group -eq $null)`
     -or ($subnet_name -eq $null) -or ($public_IP_name -eq $null)`
      -or ($resource_group -eq $null) -or ($allocation_method -eq $null)`
       -or ($sku -eq $null) -or ($bastion_host_name -eq $null)`
        -or ($location -eq $null) -or ($ip_configuration_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $virtual_network_name      = $virtual_network_name.TrimEnd(',')
    $VNET_resource_group       = $VNET_resource_group.TrimEnd(',')
    $subnet_name               = $subnet_name.TrimEnd(',')
    $public_IP_name            = $public_IP_name.TrimEnd(',')
    $resource_group            = $resource_group.TrimEnd(',')
    $allocation_method         = $allocation_method.TrimEnd(',')
    $sku                       = $sku.TrimEnd(',')
    $bastion_host_name         = $bastion_host_name.TrimEnd(',')
    $location                  = $location.TrimEnd(',')
    $ip_configuration_name     = $ip_configuration_name.TrimEnd(',')


$variable_creation = @"
VirtualNetworkName          = [$virtual_network_name]
VNETResourceGroup           = [$VNET_resource_group]
Subnet                      = [$subnet_name]
PublicIPName                = [$public_IP_name]
ExistingResourceGroupName   = [$resource_group]
AllocationMethod            = [$allocation_method]
sku                         = [$sku]
BastionHostName             = [$bastion_host_name]
Location                    = [$location]
IPConfigurationName         = [$ip_configuration_name]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################