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
	 Filename:     	Vnet_peering_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create vnet_peering_input_variables file.

    .INPUTS
        This script required excel file which contain VnetPeering worksheet details.
        
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
[string]$excel_worksheet_name = "VnetPeering"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "VnetPeering" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Peering Name')) -or ([string]::IsNullOrEmpty($data.'Local Virtual Network Resource Group')) -or ([string]::IsNullOrEmpty($data.'Local Virtual Network Name')) -or ([string]::IsNullOrEmpty($data.'Remote Virtual Network Resource Group')) -or ([string]::IsNullOrEmpty($data.'Remote Virtual Network Name')))
    {
        break
    }
    
    $peering_name    += '"' + $data.'Peering Name' + '"' + ','
    $local_vnet_rg   += '"' + $data.'Local Virtual Network Resource Group' + '"' + ','
    $local_vnet_name += '"' + $data.'Local Virtual Network Name' + '"' + ','
    $remote_vnet_id  += '"' + ((Get-AzVirtualNetwork -ResourceGroupName ($data.'Remote Virtual Network Resource Group') -Name ($data.'Remote Virtual Network Name')).Id) + '"' + ','  

}

if (($peering_name -eq $null) -or ($local_vnet_rg -eq $null) -or ($local_vnet_name -eq $null) -or ($remote_vnet_id -eq $null))
{
    Write-Error "Peering Name or Vnet details are empty please check and run again"
    exit
} 

$peering_name       = $peering_name.TrimEnd(',')
$local_vnet_rg      = $local_vnet_rg.TrimEnd(',')
$local_vnet_name    = $local_vnet_name.TrimEnd(',')
$remote_vnet_id     = $remote_vnet_id.TrimEnd(',')

$variable_creation = @"
PeeringName            = [$peering_name]
LocalVnetResourceGroup = [$local_vnet_rg]
LocalVNet              = [$local_vnet_name]
RemoteVnetID           = [$remote_vnet_id]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################