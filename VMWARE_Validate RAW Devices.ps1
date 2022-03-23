#Validar RAW Devices atriuídos
$vmHosts = get-cluster "CLUSTER10_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.list()|select Device,IsPerenniallyReserved|where {$_.Device -like  "*600507680c808312a000000000000e8b"}