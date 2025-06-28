
<#
Powershell Script to perform stiching of Front Door. 

#>
$ErrorActionPreference = 'Stop'

#region importing module
Install-Module Importexcel -force
Import-Module ImportExcel -verbose
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "AzureFrontDoor"
#endregion

#region importing excel file data
$FrontDoor = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
[string]$GWWorksheetName = "ApplicationGateway"
$AG = Import-Excel -Path $excel_file_path -WorksheetName $GWWorksheetName
#$AGget =  Get-AzApplicationGateway -ResourceGroupName $ag.'Existing Resource Group Name' -Name $ag.ApplicationGatewayName
$AGPipGet = Get-AzPublicIpAddress -Name $ag.'Public IP Name' -ResourceGroupName $ag.'Existing Resource Group Name'
$newBackend = New-AzFrontDoorBackendObject -Address $AGPipGet.IpAddress
$afd = Get-AzFrontDoor -Name $FrontDoor.'Frontdoor Hostname' -ResourceGroupName $FrontDoor.'Existing Frontdoor Resource Group'
$afd.BackendPools[-1].Backends.Add($newbackend)
$afd | Set-AzFrontDoor



