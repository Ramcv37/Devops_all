<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	26 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	vpn_gateway_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create vpn gateway input variable file.

    .INPUTS
        This script required excel file which contain VPNGateway worksheet details.
        
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
[string]$excel_worksheet_name = "VPNGateway"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "VPNGateway" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing VNET Resource Group'))`
     -or ([string]::IsNullOrEmpty($data.'VNET Gateway Name'))`
      -or ([string]::IsNullOrEmpty($data.'Gateway Type'))`
       -or ([string]::IsNullOrEmpty($data.'VPN Type'))`
        -or ([string]::IsNullOrEmpty($data.'Subnet Name')))
    {
        break
    }

    $temp_location = (Get-AzResourceGroup -Name (($data.'Existing VNET Resource Group').Trim())).Location

    $rgname            += '"' + (($data.'Existing VNET Resource Group').Trim()) + '"' + ','
    $location          += '"' + ($temp_location) + '"' + ','
    $vnet_name         += '"' + (($data.'Existing VNET Name').Trim()) + '"' + ','
    $subnet_name       += '"' + (($data.'Subnet Name').Trim()) + '"' + ','
   # $subnet_address    += '"' + (($data.'Subnet Address Prefix').Trim()) + '"' + ','
    $vnet_gateway_name += '"' + (($data.'VNET Gateway Name').Trim()) + '"' + ','
    $gateway_type      += '"' + (($data.'Gateway Type').Trim()) + '"' + ','
    $vpn_type          += '"' + (($data.'VPN Type').Trim()) + '"' + ','
    $sku               += '"' + (($data.SKU).Trim()) + '"' + ','
    $public_ip_name    += '"' + (($data.'Public IP Name').Trim()) + '"' + ','
    $allocation_method += '"' + (($data.'Allocation Method').Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($location -eq $null)`
     -or ($vnet_name -eq $null) -or ($subnet_name -eq $null) -or ($vnet_gateway_name -eq $null))
{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

    $rgname             = $rgname.TrimEnd(',')
    $location           = $location.TrimEnd(',')
    $vnet_name          = $vnet_name.TrimEnd(',')
    $subnet_name        = $subnet_name.TrimEnd(',')
   # $subnet_address     = $subnet_address.TrimEnd(',')
    $vnet_gateway_name  = $vnet_gateway_name.TrimEnd(',')
    $gateway_type       = $gateway_type.TrimEnd(',')
    $vpn_type           = $vpn_type.TrimEnd(',')
    $sku                = $sku.TrimEnd(',')
    $public_ip_name     = $public_ip_name.TrimEnd(',')
    $allocation_method  = $allocation_method.TrimEnd(',')

$variable_creation = @"
ResourceGroupName     = [$rgname]
Location              = [$location]
VirtualNetworkName    = [$vnet_name]
SubnetName            = [$subnet_name]
PublicIPName          = [$public_ip_name]
AllocationMethod      = [$allocation_method]
VNETGatewayName       = [$vnet_gateway_name]
GatewayType           = [$gateway_type]
VPNType               = [$vpn_type]
sku                   = [$sku]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################