<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	09 Sept 2021
	 Created by:   	Alok Maheshwari
	 Organization: 	HCL Technologies
	 Filename:     	application_gateway.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to add routes input variable file.

    .INPUTS
        This script required excel file which contain ApplicationGateway worksheet details.
        
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
##local setup:
#$env:artifact_name = 'C:\Users\alok.maheshwari\OneDrive - HCL Technologies Ltd\Documents\Updated-Source\hcl-cloud-coe-oneclick\foundation'
#$env:excel_file_name = 'configurationFile\Terraform-OneClick.xlsx'
#$ResourceGroupName = $null
#$VnetName = $null
#$Location = $null
#$PublicIPName = $null
#$AppGatewayName = $null
#$SubnetRGName = $null




#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "ApplicationGateway"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "ApplicationGateway" + "\" + "terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion
#$gwname = $excel_data.ApplicationGatewayName.Trim()
#$gwrgname = $excel_data.'Existing Resource Group Name'.Trim()
#$location  = $excel_data.Location.Trim()

#New-AzApplicationGateway -Name $gwname -ResourceGroupName $gwrgname -Location $location -Sku 







foreach ($data in $excel_data) {
    if (([string]::IsNullOrEmpty($data.'Vnet Name'))`
            -or ([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
            -or ([string]::IsNullOrEmpty($data.Location))`
            -or ([string]::IsNullOrEmpty($data.'Public IP Name'))`
            -or ([string]::IsNullOrEmpty($data.'Existing Gateway Subnet Resource Group'))`
            -or ([string]::IsNullOrEmpty($data.ApplicationGatewayName))) {
        break

    }


    $ResourceGroupName += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $VnetName += '"' + (($data.'vnet name').Trim()) + '"' + ','
    $Location += '"' + (($data.'Location').Trim()) + '"' + ','
    $PublicIPName += '"' + (($data.'Public IP Name')) + '"' + ','
    $AppGatewayName += '"' + (($data.ApplicationGatewayName).Trim()) + '"' + ','
    $SubnetRGName += '"' + (($data.'Existing Gateway Subnet Resource Group').Trim()) + '"' + ','

}

if ((!$ResourceGroupName) -or (!$VnetName) -or (!$Location) -or (!$PublicIPName) -or (!$AppGatewayName) -or (!$SubnetRGName)) {
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$ResourceGroupName = $ResourceGroupName.TrimEnd(',')
$VnetName = $VnetName.TrimEnd(',')
$Location = $Location.TrimEnd(',')
$PublicIPName = $PublicIPName.TrimEnd(',')
$AppGatewayName = $AppGatewayName.TrimEnd(',')
$SubnetRGName = $SubnetRGName.TrimEnd(',')

$variable_creation = @"
ResourceGroupName   = [$ResourceGroupName]
VnetName            = [$VnetName]
Location            = [$Location]
PublicIPName        = [$PublicIPName]
AppGatewayName      = [$AppGatewayName]
SubnetRGName        = [$SubnetRGName]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################