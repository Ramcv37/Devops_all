<#
Powershell script to apply Firewall rules. 
#>


$ErrorActionPreference = 'Stop'

#region importing module
Install-Module Importexcel -force
Import-Module ImportExcel -verbose
#endregion

#region parameters
[string]$excel_file_path = "$($env:artifact_name)" + "\" + "$($env:excel_file_name)"
[string]$excel_worksheet_name = "AzureFirewall"
#endregion

#region importing excel file data
$Firewall = Import-Excel -Path $excel_file_path -WorksheetName $excel_worksheet_name
#endregion

#Get Firewall. 
foreach ($item in $Firewall) {

    $fwget = Get-AzFirewall -Name $item.'Firewall Name' -ResourceGroupName $item.'Existing Resource Group for Firewall'

 #Rule set
[Array]$rule1Ports = "53", "80", "443", "1433"
[Array]$rule2Ports = "123", "53"
$Rule1 = New-AzFirewallNetworkRule -Name "Allow443" -Description "Allow 443 traffic" -SourceAddress "*" -DestinationAddress "*" -DestinationPort  $rule1Ports -Protocol TCP 
$Rule2 = New-AzFirewallNetworkRule -Name "AllowNetwork" -Protocol UDP -SourceAddress "*" -DestinationAddress "*" -DestinationPort $rule2Ports -Description "Allow UDP Traffic" 

$collection = New-AzFirewallNetworkRuleCollection -Name "Rules" -Priority 100 -Rule $Rule1, $Rule2 -ActionType Allow 
$fwget.NetworkRuleCollections = $collection
$fwget | Set-AzFirewall

}




