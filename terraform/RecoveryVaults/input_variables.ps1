<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	28 June 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	recovery_vaults_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create recovery vaults input variable file.

    .INPUTS
        This script required excel file which contain RecoveryVaults worksheet details.
        
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
[string]$excel_worksheet_name = "RecoveryVaults"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "RecoveryVaults" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Recovery Vault Name'))`
     -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
      -or ([string]::IsNullOrEmpty($data.Location))`
       -or ([string]::IsNullOrEmpty($data.SKU)))

    {
        break
    }

    $resource_group   += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $recovery_vault   += '"' + (($data.'Recovery Vault Name').Trim()) + '"' + ','
    $location         += '"' + (($data.Location).Trim()) + '"' + ','
    $sku              += '"' + (($data.SKU).Trim()) + '"' + ','
}

if (($resource_group -eq $null) -or ($recovery_vault -eq $null)`
     -or ($location -eq $null) -or ($sku -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $resource_group     = $resource_group.TrimEnd(',')
    $recovery_vault     = $recovery_vault.TrimEnd(',')
    $location           = $location.TrimEnd(',')
    $sku                = $sku.TrimEnd(',')

$variable_creation = @"
ResourceGroupName   = [$resource_group]
VaultName           = [$recovery_vault]
Location            = [$location]
SKU                 = [$sku]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################