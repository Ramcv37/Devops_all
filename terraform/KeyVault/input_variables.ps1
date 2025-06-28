<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	15 Sep 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	key_vault_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create key vault input variable file.

    .INPUTS
        This script required excel file which contain KeyVault worksheet details.
        
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
[string]$excel_worksheet_name = "KeyVault"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "KeyVault" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Key Vault Name'))`
     -or ([string]::IsNullOrEmpty($data.Location))`
      -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
       -or ([string]::IsNullOrEmpty($data.'Enable for Disk Encryption'))`
        -or ([string]::IsNullOrEmpty($data.'Soft Delete Retention Days'))`
         -or ([string]::IsNullOrEmpty($data.'Purge Protection Enabled'))`
          -or ([string]::IsNullOrEmpty($data.'SKU Name'))  )

    {
        break
    }

    $key_vault_name                += '"' + (($data.'Key Vault Name').Trim()) + '"' + ','
    $location                      += '"' + (($data.Location).Trim()) + '"' + ','
    $resource_group_name           += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $disk_encryption               += '"' + ($data.'Enable for Disk Encryption').ToString().tolower() + '"' + ','
    $soft_delete_retention_days    += '"' + ($data.'Soft Delete Retention Days') + '"' + ','
    $purge_protection_enabled      += '"' + ($data.'Purge Protection Enabled').ToString().tolower() + '"' + ','
    $sku_name                      += '"' + ($data.'SKU Name') + '"' + ','
}

if (($key_vault_name -eq $null) -or ($location -eq $null)`
     -or ($resource_group_name -eq $null) -or ($disk_encryption -eq $null)`
      -or ($soft_delete_retention_days -eq $null) -or ($purge_protection_enabled -eq $null)`
       -or ($sku_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $key_vault_name             = $key_vault_name.TrimEnd(',')
    $location                   = $location.TrimEnd(',')
    $resource_group_name        = $resource_group_name.TrimEnd(',')
    $disk_encryption            = $disk_encryption.TrimEnd(',')
    $soft_delete_retention_days = $soft_delete_retention_days.TrimEnd(',')
    $purge_protection_enabled   = $purge_protection_enabled.TrimEnd(',')
    $sku_name                   = $sku_name.TrimEnd(',')

$variable_creation = @"
KeyVaultName            = [$key_vault_name]
Location                = [$location]
ResourceGroupName       = [$resource_group_name]
DiskEncryption          = [$disk_encryption]
SoftDeleteRetentionDays = [$soft_delete_retention_days]
PurgeProtectionEnable   = [$purge_protection_enabled]
SKUName                 = [$sku_name]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################