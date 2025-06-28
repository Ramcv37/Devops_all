<#	
    ===========================================================================
    Terraform On Azure
    ===========================================================================
    
	.NOTES
	===========================================================================
	 Created with: 	PowerShell ISE
	 Created on:   	09 Oct 2021
	 Created by:   	Neetima
	 Organization: 	HCL Technologies
	 Filename:     	AzureFrontDoor_input_variables.ps1
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

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "AzureFrontDoor"
[string]$save_terraform_variable_file = "$($env:artifact_name)" + "\terraform\" + "AzureFrontDoor" + "\" +"terraform.tfvars"

#endregion

#region importing excel file data
$excel_data = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name 
#endregion

foreach ($data in $excel_data)
{
    if (([string]::IsNullOrEmpty($data.'Existing Frontdoor Resource Group'))`
     -or ([string]::IsNullOrEmpty($data.'Frontdoor Hostname'))`
      -or ([string]::IsNullOrEmpty($data.'Routing Rule Name'))`
      -or ([string]::IsNullOrEmpty($data.'Backend Host Header'))`
      -or ([string]::IsNullOrEmpty($data.'Backend Host Address'))`
)

    {
        break
    }

    $frontdoor_rgname             += '"' + (($data.'Existing Frontdoor Resource Group').Trim()) + '"' + ','
    $frontdoor_hostname           += '"' + (($data.'Frontdoor Hostname').Trim()) + '"' + ','
    $routing_rule                 += '"' + (($data.'Routing Rule Name').Trim()) + '"' + ','
    $host_header                  += '"' + (($data.'Backend Host Header').Trim()) + '"' + ','
    $host_address                 += '"' + (($data.'Backend Host Address').Trim()) + '"' + ','

}

if (($frontdoor_rgname -eq $null)`
  -or ($frontdoor_hostname -eq $null)`
   -or ($routing_rule -eq $null)`
   -or ($host_header -eq $null)`
   -or ($host_address -eq $null)`

    )

{
    Write-Error "Some of the Parameters have empty values please check parameters and run again"
    exit
} 

$frontdoor_rgname               = $frontdoor_rgname.TrimEnd(',')
$frontdoor_hostname             = $frontdoor_hostname.TrimEnd(',')
$routing_rule                   = $routing_rule.TrimEnd(',')
$host_header                    = $host_header.TrimEnd(',')
$host_address                   = $host_address.TrimEnd(',')


$variable_creation = @"
FrontendEndpointName    = [$frontdoor_hostname]
ResourceGroupName       = [$frontdoor_rgname]
RoutingRuleName         = [$routing_rule]
HostHeader              = [$host_header]
Address                 = [$host_address]

"@

$variable_creation | Out-File -FilePath $save_terraform_variable_file -Encoding utf8 -Force

#################################################### END OF SCRIPT ############################################################