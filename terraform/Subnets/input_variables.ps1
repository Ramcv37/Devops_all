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
	 Filename:     	subnet_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create subnets input variable file.

    .INPUTS
        This script required excel file which contain subnets worksheet details.
        
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
[string]$excel_worksheet_name = "Subnets"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "subnets" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing VNET Resource Group Name'))`
    -or ([string]::IsNullOrEmpty($data.'Existing VNET Name'))`
    -or ([string]::IsNullOrEmpty($data.'Subnet Name'))`
    -or ([string]::IsNullOrEmpty($data.'Address Prefixes'))`
    -or ([string]::IsNullOrEmpty($data.'enforce_private_link_endpoint'))`
    -or ([string]::IsNullOrEmpty($data.'enforce_private_link_service')))
    {
        break
    }
    
    $rgname        += '"' + (($data.'Existing VNET Resource Group Name').Trim()) + '"' + ','
    $subnet_name   += '"' + (($data.'Subnet Name').Trim()) + '"' + ','
    $VnetName      += '"' + (($data.'Existing VNET Name').Trim()) + '"' + ','
    $Address_Space += '"' + (($data.'Address Prefixes').Trim()) + '"' + ','
    $enforce_pep   += '"' + (($data.'enforce_private_link_endpoint')) + '"' + ','
    $enforce_private_link_service += '"' + (($data.'enforce_private_link_service')) + '"' + ','
}

if (($rgname -eq $null) -or ($VnetName -eq $null) -or ($Address_Space -eq $null) -or ($subnet_name -eq $null) -or ($enforce_pep -eq $null) -or ($enforce_private_link_service -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$rgname        = $rgname.TrimEnd(',')
$subnet_name   = $subnet_name.TrimEnd(',')
$VnetName      = $VnetName.TrimEnd(',')
$Address_Space = $Address_Space.TrimEnd(',')
$enforce_pep = $enforce_pep.TrimEnd(',')
$enforce_private_link_service = $enforce_private_link_service.TrimEnd(',')

$variable_creation = @"
VirtualNetworkName          = [$VnetName]
SubnetName                  = [$subnet_name]
VirtualNetworkResourceGroup = [$rgname]
AddressSpace                = [$Address_Space]
enforce_pep                 = [$enforce_pep]
enforce_private_link_service= [$enforce_private_link_service]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################