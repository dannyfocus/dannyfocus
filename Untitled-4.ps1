
#Código solto

#VALIDAR
$vmHosts = get-cluster "CLUSTER_PROD" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.list()|select Device,IsPerenniallyReserved|where {$_.Device -like  "*Insert LUNID here*"}

#ADICIONAR
$vmHosts = get-cluster "CLUSTER_PROD" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,"naa.Insert LUNID here", $true)


#Listar VMs com Raw Devices
get-cluster CLUSTER_PROD | Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl

#Listar VMs com Raw Devices com output
Get-cluster CLUSTER_PROD |Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File –FilePath VM_List.csv

#Listar VMs por Cluster
Get-cluster CLUSTER_PROD | Get-VM | Select Name | out-file -filepath VM-list.txt

#Vários objectos
$LunIDs =  "naa.LUNID","naa.LUNID","naa.LUNID","naa.LUNID","naa.LUNID","naa.LUNID","naa.LUNID"
$Clustername = "setpsfiesx41.domain.loc"

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
$esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc")
0..1 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120}

#Com confirmação  
$esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc", "esxihost3.domain.loc", "esxihost4.domain.loc", "esxihost5.domain.loc", "esxihost6.domain.loc")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120 -Confirm:$false}

$esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc", "esxihost3.domain.loc", "esxihost4.domain.loc", "esxihost5.domain.loc", "esxihost6.domain.loc")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name Security.AccountUnlockTime | Set-AdvancedSetting -Value 120}

#Adição do BUN nos hosts de VMware
$esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc", "esxihost3.domain.loc", "esxihost4.domain.loc", "esxihost5.domain.loc", "esxihost6.domain.loc")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -name Annotations.WelcomeMessage | Set-AdvancedSetting -value "Insert BUN here"}

$esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc", "esxihost3.domain.loc", "esxihost4.domain.loc", "esxihost5.domain.loc", "esxihost6.domain.loc")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name 'Config.Etc.issue' | Set-AdvancedSetting -value "Insert BUN here"}


#retrive list of Vlans
Get-Cluster | Get-VMHost | Foreach-Object {$strClusterName = $_.Parent.Name; Get-VirtualPortGroup $_ | Select-Object @{N="Cluster";E={$strClusterName}},Name,VLanId} |out-file vlans_list.csv


#código do Bule para fazer retirada das datastores e vlans
Set-Location C:\ESX\
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
Select -Property Name, @{N="Configured OS";E={$_.Config.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}} | Export-CSV C:\Users\user\Desktop\report.csv -NoTypeInformation


#Report de validação de raw devices por cluster
get-cluster CLUSTER_PROD | Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File C:\Users\user\Desktop\report.csv


get-cluster CLUSTER_PROD | Get-VM | Get-HardDisk | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | Out-File C:\Users\user\Desktop\VMDKs_LUNs_report.csv

#Report para apresentar LUN ID 
Get-Datastore | Select Name,CapacityGB,@{N='DateTime';E={Get-Date}},@{N='CanonicalName';E={$_.ExtensionData.Info.Vmfs.Extent[0].DiskName}},
@{N='LUN';E={
$esx = Get-View -Id $_.ExtensionData.Host[0].Key -Property Name
$dev = $_.ExtensionData.Info.Vmfs.Extent[0].DiskName
$esxcli = Get-EsxCli -VMHost $esx.Name -V2
$esxcli.storage.nmp.path.list.Invoke(@{'device'=$dev}).RuntimeName.Split(':')[-1].TrimStart('L')}} | Out-File C:\Users\user\Desktop\report.csv

#listar VMDKs por datastore
$outputFile = "C:\Users\user\Desktop\VMDKs_LUNs_report.csv" 
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


get-cluster CLUSTER_PROD | get-vm | get-harddisk 


get-cluster CLUSTER_PROD| get-vm | get-harddisk | select filename, capacity | ft-auto | Out-File C:\Users\user\Desktop\VMDKs_LUNs_report.csv

Get-VMHost "esxihost.domain.loc" | Sort Name | %{
    $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
    $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
    $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
    [pscustomobject][ordered]@{
      Name="$($_.name)"
      InstallDate=$installDate
    } 
 } 
 
 Get-VMHost "sppt1piesx104.domain.loc"  | Get-View |  Select Name,{$_.Config.Product.FullName},{$_.Config.Product.Build} | ft -auto
 
 
 Get-VMHost "sppt1peesx101.domain.loc" | Sort Name | %{
    $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
    $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
    $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
    [pscustomobject][ordered]@{
      Name="$($_.name)"
      InstallDate=$installDate
    } 
 }

 #erros
 $esxi = @("esxihost1.domain.loc", "esxihost2.domain.loc", "esxihost3.domain.loc", "esxihost4.domain.loc", "esxihost5.domain.loc")
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
 @{N="IP Address";E={($_.Config.Network.Vnic | ? {$_.Device -eq "vmk0"}).Spec.Ip.IpAddress}} | Out-File C:\Users\user\Desktop\Host_Lisboa_report.csv


 #Listar Vms com snapshots
 Get-vm | get-snapshot | format-list vm,name,created, Description | Out-File C:\Users\user\Desktop\Snapshots_Lisboa_report.csv