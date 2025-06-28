<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	16 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	virtual_network_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create virtual network input variable file.

    .INPUTS
        This script required excel file which contain VirtualNetwork worksheet details.
        
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
Import-Module ImportExcel
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "VirtualNetwork"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "VirtualNetwork" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name')) -or ([string]::IsNullOrEmpty($data.'Vnet Name')) -or ([string]::IsNullOrEmpty($data.'Address Space')))
    {
        break
    }
    $rgname        += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $location      += '"' + (($data.Location).Trim()) + '"' + ','
    $VnetName      += '"' + (($data.'Vnet Name').Trim()) + '"' + ','
    $Address_Space += '"' + (($data.'Address Space').Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($VnetName -eq $null) -or ($Address_Space -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$rgname        = $rgname.TrimEnd(',')
$location      = $location.TrimEnd(',')
$VnetName      = $VnetName.TrimEnd(',')
$Address_Space = $Address_Space.TrimEnd(',')

$variable_creation = @"
VirtualNetworkName          = [$VnetName]
VirtualNetworkLocation      = [$location]
VirtualNetworkResourceGroup = [$rgname]
AddressSpace                = [$Address_Space]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################