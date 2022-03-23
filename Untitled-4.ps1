
#VALIDAR
$vmHosts = get-cluster "CLUSTER24_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.list()|select Device,IsPerenniallyReserved|where {$_.Device -like  "*600507680c808312a000000000000305*"}

#ADICIONAR
$vmHosts = get-cluster "CLUSTER24_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000034", $true)


#Listar VMs com Raw Devices
get-cluster CLUSTER20_PROD_GS | Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl

#Listar VMs com Raw Devices com output
Get-cluster CLUSTER20_PROD_GS |Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File –FilePath VM_List.csv

#Listar VMs por Cluster
Get-cluster CLUSTER20_PROD_GS | Get-VM | Select Name | out-file -filepath VM-list.txt

<#
Lista:
600507680c808312a0000000000006e0
600507680c808312a0000000000006e2
600507680c808312a0000000000006e3
600507680c808312a0000000000006df
600507680c808312a0000000000006de
600507680c808312a0000000000006dd
600507680c808312a0000000000006e1
#>

$LunIDs =  "naa.600507680c808312a0000000000006e0","naa.600507680c808312a0000000000006e2","naa.600507680c808312a0000000000006e3","naa.600507680c808312a0000000000006df","naa.600507680c808312a0000000000006de","naa.600507680c808312a0000000000006dd","naa.600507680c808312a0000000000006e1"
$Clustername = "setpsfiesx41.bcpcorp.net"

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


#Alterar configuração em vários hosts
$esxi = @("setpsfiesx31.bcpcorp.net", "setpsfiesx33.bcpcorp.net")
0..1 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120}

#Com confirmação  
$esxi = @("septdriesx31.bcpcorp.net", "septdriesx32.bcpcorp.net", "septdriesx30.bcpcorp.net", "septdriesx33.bcpcorp.net", "sppt2piesx101.bcpcorp.net", "sppt2piesx102.bcpcorp.net", "septdriesx11.bcpcorp.net", "septdriesx12.bcpcorp.net", "sppt2piesx201.bcpcorp.net", "septdreesx22.bcpcorp.net", "septdreesx21", "septiziesx21.bcpcorp.net", "sppt2peesx201.bcpcorp.net", "septiziesx23.bcpcorp.net", "septiziesx22.bcpcorp.net", "sppt2peesx101.bcpcorp.net", "sppt2peesx102.bcpcorp.net")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120 -Confirm:$false}

$esxi = @("septdriesx31.bcpcorp.net", "septdriesx32.bcpcorp.net", "septdriesx30.bcpcorp.net", "septdriesx33.bcpcorp.net", "sppt2piesx101.bcpcorp.net", "sppt2piesx102.bcpcorp.net", "septdriesx11.bcpcorp.net", "septdriesx12.bcpcorp.net", "sppt2piesx201.bcpcorp.net", "septdreesx22.bcpcorp.net", "septdreesx21", "septiziesx21.bcpcorp.net", "sppt2peesx201.bcpcorp.net", "septiziesx23.bcpcorp.net", "septiziesx22.bcpcorp.net", "sppt2peesx101.bcpcorp.net", "sppt2peesx102.bcpcorp.net")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120}

#Adição do BUN nos hosts de VMware
$esxi = @("septdriesx31.bcpcorp.net", "septdriesx32.bcpcorp.net", "septdriesx30.bcpcorp.net", "septdriesx33.bcpcorp.net", "sppt2piesx101.bcpcorp.net", "sppt2piesx102.bcpcorp.net", "septdriesx11.bcpcorp.net", "septdriesx12.bcpcorp.net", "sppt2piesx201.bcpcorp.net", "septdreesx22.bcpcorp.net", "septdreesx21", "septiziesx21.bcpcorp.net", "sppt2peesx201.bcpcorp.net", "septiziesx23.bcpcorp.net", "septiziesx22.bcpcorp.net", "sppt2peesx101.bcpcorp.net", "sppt2peesx102.bcpcorp.net")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -name Annotations.WelcomeMessage | Set-AdvancedSetting -value "Os Sistemas de Informação Internos do Grupo Millenniumbcp são exclusivos e de acesso restrito às empresas que o integram para o desenvolvimento das respectivas actividades. Apenas são admitidos acessos de entidades externas quando seja necessário para a execução de alguma tarefa devidamente autorizada.
Se não está autorizado a aceder a este sistema, por favor DESLIGUE imediatamente.
Qualquer tentativa ilegal de acesso, mesmo quando rejeitada, pode implicar procedimento civil e criminal, pelo que fica desde já notificado que está sujeito a tais consequências no caso de persistir.
Este sistema está sujeito a auditorias efectuadas a qualquer momento.
Millenniumbcp Group's internal information systems are exclusive and under restricted access to its members for pursuing their activity. Third-parties are only allowed to access when necessary to execute a specific authorized task. If you are not authorized to access this system, please DISCONNECT immediately. Any illegal attempt of access, even when rejected, might be subject of civil and criminal procedure, therefore you're notified of such consequences from this moment on, should you persist.
This system might be audited at any time."}

$esxi = @("septdriesx31.bcpcorp.net", "septdriesx32.bcpcorp.net", "septdriesx30.bcpcorp.net", "septdriesx33.bcpcorp.net", "sppt2piesx101.bcpcorp.net", "sppt2piesx102.bcpcorp.net", "septdriesx11.bcpcorp.net", "septdriesx12.bcpcorp.net", "sppt2piesx201.bcpcorp.net", "septdreesx22.bcpcorp.net", "septdreesx21", "septiziesx21.bcpcorp.net", "sppt2peesx201.bcpcorp.net", "septiziesx23.bcpcorp.net", "septiziesx22.bcpcorp.net", "sppt2peesx101.bcpcorp.net", "sppt2peesx102.bcpcorp.net")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name 'Config.Etc.issue' | Set-AdvancedSetting -value "Os Sistemas de Informação Internos do Grupo Millenniumbcp são exclusivos e de acesso restrito às empresas que o integram para o desenvolvimento das respectivas actividades. Apenas são admitidos acessos de entidades externas quando seja necessário para a execução de alguma tarefa devidamente autorizada.
Se não está autorizado a aceder a este sistema, por favor DESLIGUE imediatamente.
Qualquer tentativa ilegal de acesso, mesmo quando rejeitada, pode implicar procedimento civil e criminal, pelo que fica desde já notificado que está sujeito a tais consequências no caso de persistir.
Este sistema está sujeito a auditorias efectuadas a qualquer momento.
Millenniumbcp Group's internal information systems are exclusive and under restricted access to its members for pursuing their activity. Third-parties are only allowed to access when necessary to execute a specific authorized task. If you are not authorized to access this system, please DISCONNECT immediately. Any illegal attempt of access, even when rejected, might be subject of civil and criminal procedure, therefore you're notified of such consequences from this moment on, should you persist.
This system might be audited at any time."}


#retrive list of Vlans
Get-Cluster | Get-VMHost | Foreach-Object {$strClusterName = $_.Parent.Name; Get-VirtualPortGroup $_ | Select-Object @{N="Cluster";E={$strClusterName}},Name,VLanId} |out-file vlans_list.csv


#código do Bule para fazer retirada das datastores e vlans
Set-Location C:\Software\ESX\
if (Test-Path .\vmfile.csv) {Remove-Item .\vmfile.csv}
Write-host "Checking vCenter resources..."
Import-Module -name VMware.VimAutomation.Core
If ($global:DefaultVIServer -eq $NULL){
	If(-not (Get-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue)){
		Write-Host "Loading VMWare Snap-In.."
		Import-Module -name VMware.VimAutomation.Core
	}
	Connect-VIServer {{vcenter}} -user {{vcuser}} -password {{password}}
}
if ("{{resource}}" -like "Datastore") 
{
	$clusters = get-cluster
	foreach ($cluster in $clusters)	{
		$vmhosts = $cluster | get-vmhost
		$firsthost = $vmhosts[0]
		$datastores = $firsthost | get-datastore | % {(Get-View $_.ID).summary}
		foreach ($datastore in $datastores) {$datastore | select-object @{Name = "Cluster"; Expression = {$cluster.name}}, Name, Freespace, Capacity | ConvertTo-CSV -NoTypeInformation | Out-File .\vmfile.csv -append}
	}
get-content .\vmfile.csv | select-object -unique | Set-Content -Encoding ASCII .\vmfile.csv
}
else 
{
Get-Cluster | Get-VMHost | Foreach-Object {$strClusterName = $_.Parent.Name; Get-VirtualPortGroup $_ | Select-Object @{N="Cluster";E={$strClusterName}},Name,VLanId} | Export-Csv -Path "vmfile.csv" -Force -NoTypeInformation
}




Get-VM | Sort-Object -Property Name | Get-View -Property @("Name", "Config.GuestFullName", "Guest.GuestFullName", "vmhost") |
Select -Property Name, @{N="Configured OS";E={$_.Config.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}} | Export-CSV C:\Users\o344332\Desktop\report.csv -NoTypeInformation


#Report de validação de raw devices por cluster
get-cluster CLUSTER20_PROD_TP | Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File C:\Users\o344332\Desktop\report.csv


get-cluster CLUSTER20_PROD_TP | Get-VM | Get-HardDisk | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File C:\Users\o344332\Desktop\VMDKs_LUNs_report.csv

#Report para apresentar LUN ID 
Get-Datastore | Select Name,CapacityGB,@{N='DateTime';E={Get-Date}},@{N='CanonicalName';E={$_.ExtensionData.Info.Vmfs.Extent[0].DiskName}},
@{N='LUN';E={
$esx = Get-View -Id $_.ExtensionData.Host[0].Key -Property Name
$dev = $_.ExtensionData.Info.Vmfs.Extent[0].DiskName
$esxcli = Get-EsxCli -VMHost $esx.Name -V2
$esxcli.storage.nmp.path.list.Invoke(@{'device'=$dev}).RuntimeName.Split(':')[-1].TrimStart('L')}} | Out-File C:\Users\o344332\Desktop\report.csv

#listar VMDKs por datastore
$outputFile = "C:\Users\o344332\Desktop\VMDKs_LUNs_report.csv" 
$VMsAdv = Get-VM | Sort-Object Name | % { Get-View $_.ID } 
$myCol = @() 
ForEach ($VMAdv in $VMsAdv) 
{ 
    ForEach ($Disk in $VMAdv.Layout.Disk) 
    { 
        $myObj = "" | Select-Object Name, Disk, sizeGB
        $myObj.Name = $VMAdv.Name 
        $myObj.Disk = $Disk.DiskFile[0]
        $myObj.Disk = $Disk.Disksize[1] 
        $myCol += $myObj 
    } 
} 
$myCol | Export-Csv $outputFile -NoTypeInformation

get-cluster CLUSTER20_PROD_TP | get-vm | get-harddisk 

get-cluster CLUSTER20_PROD_TP | get-vm | get-harddisk | select filename, capacity | ft-auto | Out-File C:\Users\o344332\Desktop\VMDKs_LUNs_report.csv

Get-VMHost "sppt1piesx104.bcpcorp.net" | Sort Name | %{
    $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
    $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
    $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
    [pscustomobject][ordered]@{
      Name="$($_.name)"
      InstallDate=$installDate
    } 
 } 
 
 Get-VMHost "sppt1piesx104.bcpcorp.net"  | Get-View |  Select Name,{$_.Config.Product.FullName},{$_.Config.Product.Build} | ft -auto
 
 
 Get-VMHost "sppt1peesx101.bcpcorp.net" | Sort Name | %{
    $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
    $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
    $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
    [pscustomobject][ordered]@{
      Name="$($_.name)"
      InstallDate=$installDate
    } 
 }

 
 $esxi = @("setpsfiesx30.bcpcorp.net", "setpsfiesx31.bcpcorp.net", "setpsfiesx32.bcpcorp.net", "setpsfiesx33.bcpcorp.net", "setpsfiesx34.bcpcorp.net")
0..4 | foreach-object {
$index = $_
Get-VMHost $esxi[$index] | Sort Name | %{
   $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
   $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
   $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
   [pscustomobject][ordered]@{
     Name="$($_.name)"
     InstallDate=$installDate
   } 
  } 
}
0..4 | foreach-object {
$index = $_
Get-VMHost $esxi[$index] | Get-View |  Select Name,{$_.Config.Product.FullName},{$_.Config.Product.Build} | ft -auto
}
 


 #Indica o vcenter a versão e build
 $Global:DefaultVIServers | select Name, Version, Build
 
 
 get-cluster | Get-VMHost | Sort Name | Get-View | Select Name,
 @{N="IP Address";E={($_.Config.Network.Vnic | ? {$_.Device -eq "vmk0"}).Spec.Ip.IpAddress}} | Out-File C:\Users\o344332\Desktop\Host_Lisboa_report.csv


 #Listar Vms com snapshots
 Get-vm | get-snapshot | format-list vm,name,created, Description | Out-File C:\Users\o344332\Desktop\Snapshots_Lisboa_report.csv