<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	27 May 2021
	 Created by:   	Rahul Sawant
	 Organization: 	HCL Technologies
	 Filename:     	connections_input_variables.ps1
	===========================================================================

	.DESCRIPTION
		This script is design to create connections input variable file.

    .INPUTS
        This script required excel file which contain Connections worksheet details.
        
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
[string]$excel_worksheet_name = "Connections"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "Connections" + "\" +"terraform.tfvars"
#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Resource Group Name'))`
     -or ([string]::IsNullOrEmpty($data.'Connection Name'))`
      -or ([string]::IsNullOrEmpty($data.'VPN Gateway Name'))`
       -or ([string]::IsNullOrEmpty($data.'VPN Gateway Resource Group'))`
        -or ([string]::IsNullOrEmpty($data.'Local Network Gateway Name'))`
         -or ([string]::IsNullOrEmpty($data.'Local Network Gateway Resource Group')))

    {
        break
    }

    $temp_location = (Get-AzResourceGroup -Name (($data.'Existing Resource Group Name').Trim())).Location
    $temp_gateway_id = (Get-AzVirtualNetworkGateway -Name (($data.'VPN Gateway Name').Trim()) -ResourceGroupName (($data.'VPN Gateway Resource Group').Trim())).Id
    $temp_local_network_gateway_id = (Get-AzLocalNetworkGateway -Name (($data.'Local Network Gateway Name').Trim()) -ResourceGroupName (($data.'Local Network Gateway Resource Group').Trim())).Id

    $rgname                     += '"' + (($data.'Existing Resource Group Name').Trim()) + '"' + ','
    $location                   += '"' + ($temp_location) + '"' + ','
    $connection_name            += '"' + (($data.'Connection Name').Trim()) + '"' + ','
    $vpn_gateway_id             += '"' + ($temp_gateway_id) + '"' + ','
    $local_network_gateway_id   += '"' + ($temp_local_network_gateway_id) + '"' + ','
    $shared_key                 += '"' + (($data.'Shared Key').Trim()) + '"' + ','
}

if (($rgname -eq $null) -or ($location -eq $null) -or ($connection_name -eq $null)`
     -or ($vpn_gateway_id -eq $null) -or ($local_network_gateway_id -eq $null))
{
    Write-Error "Resource Group or Location or Gateway Name or Local network gateway have empty values please check parameters and run again"
    exit
} 

    $rgname                    = $rgname.TrimEnd(',')
    $location                  = $location.TrimEnd(',')
    $connection_name           = $connection_name.TrimEnd(',')
    $vpn_gateway_id            = $vpn_gateway_id.TrimEnd(',')
    $local_network_gateway_id  = $local_network_gateway_id.TrimEnd(',')
    $shared_key                = $shared_key.TrimEnd(',')

$variable_creation = @"
ResourceGroupName       = [$rgname]
ResourceGroupLocation   = [$location]
ConnectionName          = [$connection_name]
VPNGatewayID            = [$vpn_gateway_id]
LocalNetworkgatewayID   = [$local_network_gateway_id]
SharedKey               = [$shared_key]
"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################