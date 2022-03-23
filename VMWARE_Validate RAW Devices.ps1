#Validar RAW Devices atriuídos
$vmHosts = get-cluster "CLUSTER_PROD" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.list()|select Device,IsPerenniallyReserved|where {$_.Device -like  "*Insert LUNID here"}