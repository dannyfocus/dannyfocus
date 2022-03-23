#Retirar LUNs do VMware

# Correr o script e ele irá pedir os valores, não é necessário escrita no código

#Insere LUN ID aqui
$LunIDs =  Read-Host "Enter NAA ID here"

#Insere CLUSTER aqui
$Clustername = Read-Host "Enter CLUSTER here"

#######################################################
###				        Inicio              		###
#######################################################

function Detach-Disk {
    param(
        [VMware.VimAutomation.ViCore.Impl.V1.Inventory.VMHostImpl]$VMHost,
        [string]$CanonicalName    )

    $storSys = Get-View $VMHost.Extensiondata.ConfigManager.StorageSystem
    $lunUuid = (Get-ScsiLun -VmHost $VMHost | where {$_.CanonicalName -eq $CanonicalName}).ExtensionData.Uuid

    $storSys.DetachScsiLun($lunUuid)
}

#######################################################
###				         Fim                  		###
#######################################################

$ClusterHosts = Get-Cluster $Clustername | Get-VMHost
Foreach($VMHost in $ClusterHosts)
{
    Foreach($LUNid in $LunIDs)
    {
        Write-Host "Detaching" $LUNid "from" $VMHost -ForegroundColor "Yellow"
        Detach-Disk -VMHost $VMHost -CanonicalName $LUNid
    }
}