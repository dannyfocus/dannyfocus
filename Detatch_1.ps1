$LunIDs =  "naa.LUNID"
$Clustername = "CLUSTER_DEV","CLUSTER1_PROD","CLUSTER2_PROD"

function Detach-Disk {
    param(
        [VMware.VimAutomation.ViCore.Impl.V1.Inventory.VMHostImpl]$VMHost,
        [string]$CanonicalName    )

    $storSys = Get-View $VMHost.Extensiondata.ConfigManager.StorageSystem
    $lunUuid = (Get-ScsiLun -VmHost $VMHost | where {$_.CanonicalName -eq $CanonicalName}).ExtensionData.Uuid

    $storSys.DetachScsiLun($lunUuid)
}

$ClusterHosts = Get-Cluster $Clustername | Get-VMHost

Foreach($VMHost in $ClusterHosts)
{
    Foreach($LUNid in $LunIDs)
    {
        Write-Host "Detaching" $LUNid "from" $VMHost -ForegroundColor "Yellow"
        Detach-Disk -VMHost $VMHost -CanonicalName $LUNid
    }
}