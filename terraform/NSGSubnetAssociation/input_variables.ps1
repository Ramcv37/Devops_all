<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	21 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	NSG-Subnet-Association_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create NSG-Subnet-Association_input_variables file.

    .INPUTS
        This script required excel file which contain NSG-Subnet-Association worksheet details.
        
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
Install-Module -Name Az
Import-Module ImportExcel -verbose
Import-Module Az
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "NSG-Subnet-Association"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "NSGSubnetAssociation" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing NSG Resource Group Name')) -or ([string]::IsNullOrEmpty($data.'Existing NSG Name')) -or ([string]::IsNullOrEmpty($data.'Existing Virtual Network Name')) -or ([string]::IsNullOrEmpty($data.'Existing Virtual Network Resource Group')) -or ([string]::IsNullOrEmpty($data.'Existing Subnet Name')))
    {
        break
    }
    
    $subnet_id += '"' + (Get-AzVirtualNetwork -Name ($data.'Existing Virtual Network Name') -ResourceGroupName ($data.'Existing Virtual Network Resource Group') | Get-AzVirtualNetworkSubnetConfig | Where-Object {$_.Name -eq $data.'Existing Subnet Name'}).Id + '"' + ','
    $nsg_id    += '"' + (Get-AzNetworkSecurityGroup -Name ($data.'Existing NSG Name') -ResourceGroupName ($data.'Existing NSG Resource Group Name')).Id + '"' + ','
}

if (($subnet_id -eq $null) -or ($nsg_id -eq $null))
{
    Write-Error "NSG id or Subnet id have empty values please check and run again"
    exit
} 

$subnet_id   = $subnet_id.TrimEnd(',')
$nsg_id      = $nsg_id.TrimEnd(',')

$variable_creation = @"
subnetID  = [$subnet_id]
NSGID     = [$nsg_id]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################