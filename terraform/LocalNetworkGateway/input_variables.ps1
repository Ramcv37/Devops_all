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
	 Filename:     	local_network_gateway_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create local network gateway input variable file.

    .INPUTS
        This script required excel file which contain LocalNetworkGateway worksheet details.
        
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
[string]$excel_worksheet_name = "LocalNetworkGateway"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "LocalNetworkGateway" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'Local Gateway Name'))`
      -or ([string]::IsNullOrEmpty($data.'Gateway Address'))`
       -or ([string]::IsNullOrEmpty($data.'Address Space')))

    {
        break
    }

    $temp_location = (Get-AzResourceGroup -Name (($data.'Existing Resource Group Name').Trim())).Location

    $rgname            += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $location          += '"' + ($temp_location) + '"' + ','
    $gateway_name      += '"' + (($data.'Local Gateway Name').Trim()) + '"' + ','
    $gateway_address   += '"' + (($data.'Gateway Address').Trim()) + '"' + ','
    $address_space     += '"' + (($data.'Address Space').Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($location -eq $null)`
     -or ($gateway_name -eq $null) -or ($gateway_address -eq $null)`
        -or ($address_space -eq $null))
{
    Write-Error "Resource Group or Location or Gateway Name or Address space have empty values please check parameters and run again"
    exit
} 

    $rgname             = $rgname.TrimEnd(',')
    $location           = $location.TrimEnd(',')
    $gateway_name       = $gateway_name.TrimEnd(',')
    $gateway_address    = $gateway_address.TrimEnd(',')
    $address_space      = $address_space.TrimEnd(',')

$variable_creation = @"
ResourceGroupName     = [$rgname]
Location              = [$location]
GatewayName           = [$gateway_name]
GatewayAddress        = [$gateway_address]
AddressSpace          = [$address_space]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################