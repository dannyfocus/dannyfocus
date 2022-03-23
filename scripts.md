**Scripts de VMware**

## Adição de um host novo

  

### Criar vSwitch

New-VirtualSwitch -VMHost esxihost(renomear) -Name vSwitch1 -nic vmnic4,vmnic5 -mtu 1500

### Criar portgroups

Get-VMHost esxihost(renomear) | Get-VirtualSwitch -name vSwitchx | New-VirtualPortGroup -name "VLANXXX-Database-Replication" -VLANId 1.2.3

  
### Reservar Raw Devices

$vmHosts = get-cluster "CLUSTER_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false, "naa.600507680c808312a000000000000cca(ID do raw device em minusculas)",$true)

  

### Adicionar raw device ao servidor

New-HardDisk -VM VMName -DiskType RawPhysical -DeviceName /vmfs/devices/disks/naa.IDRawdevice -Controller "SCSI controller 1"

  

### Adicionar disco existente (criado no outro par)

New-HardDisk -VM VMName -DiskPath "[datastore] localização_do_disco.vmdk" -Controller "SCSI controller 1"

  

 # Correr no host

### Criar users

New-VMHostAccount -Id username -password PASSWORD -Description "Descrição"
New-VMHostAccount -Id username -password PASSWORD -Description "Descrição"

### Alteração da descrição dos users

Set-VMHostAccount -UserAccount "vpxuser" -Description "Descrição" | ft -auto
Set-VMHostAccount -UserAccount "dcui" -Description "Descrição" | ft -auto
Set-VMHostAccount -UserAccount "root" -Description "Descrição" | ft -auto

  

### validar users

Get-VMHostAccount | ft -auto

  

### Renomear Datastores

Get-Datastore -name datastore1 | Set-Datastore -name esxihost(renomear)_001_r1_internal

  

### Criar pasta Log

$datastore = Get-Datastore -Name esxihost(renomear)_001_r1_internal
New-PSDrive -Location $datastore -Name DS -PSProvider VimDatastore -Root "\"
New-Item -Path DS:\Log -ItemType Directory
Remove-PSDrive -Name DS -Confirm:$false

  

## Correr no vcenter

### Configuração SysLog

Get-AdvancedSetting -Entity esxihost(renomear) -Name "VMFS3.UseATSForHBOnVMFS5" | Set-AdvancedSetting -Value "0" | ft -auto
Get-AdvancedSetting -Entity esxihost(renomear) -Name "Syslog.global.logHost" | Set-AdvancedSetting -Value "udp://IP:PORT" | ft -auto
Get-AdvancedSetting -Entity esxihost(renomear) -Name "Syslog.global.logDirUnique" | Set-AdvancedSetting -Value "true" | ft -auto
Get-AdvancedSetting -Entity esxihost(renomear) -Name "Syslog.global.logDir" | Set-AdvancedSetting -Value "[esxihost(renomear)_001_r1_internal] Log" | ft -auto
Get-VMHost -Name esxihost(renomear) | Get-VMHostFirewallException | where {$_.Name -eq "syslog"} | Set-VMHostFirewallException -Enabled $true -Confirm:$false

### Configuração NTP

Get-VMHost esxihost(renomear) | Add-VMHostNtpServer -NtpServer "IP" , "IP" | ft -auto

### Start NTP client service and set to automatic

Get-VmHostService -VMHost esxihost(renomear) | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VmHostService -VMHost esxihost(renomear) | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
Get-VMHostFirewallException -VMHost esxihost(renomear) | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true

### Configuração Time Configuration

Get-VMHost esxihost(renomear) | Get-VMHostService | where {$_.Key -eq "ntpd"} |Set-VMHostService -Policy "on"

  

### validar estado do NTP

Get-VMHost | Get-VmHostService | Where-Object {$_.key -eq "ntpd"}

  

### Password Complexity

Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'Security.PasswordQualityControl' | Set-AdvancedSetting -value "retry=3 min=disabled,disabled,disabled,15,15"

  

### BUN

Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'Annotations.WelcomeMessage' | Set-AdvancedSetting -value "Right BUN here"
Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'Config.Etc.issue' | Set-AdvancedSetting -value "Right BUN here"

  

### Account Unlock Time

Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'Security.AccountUnlockTime' | Set-AdvancedSetting -value "120"

  

### Account

Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'Security.AccountLockFailures' | Set-AdvancedSetting -value "10"

  

### ESXi Shell and SSH idle session timeout

Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'UserVars.ESXiShellTimeOut' | Set-AdvancedSetting -value "600"
Get-VMHost esxihost(renomear) | Get-AdvancedSetting -Name 'UserVars.ESXiShellInteractiveTimeOut' | Set-AdvancedSetting -value "14400"

  
  

### Stop SSH and change configurations

Get-VMHost esxihost(renomear) | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"}) -Confirm:$false }
Get-VMHost esxihost(renomear) | get-vmhostservice | where-object {$_.key -eq "TSM-SSH"} | set-vmhostservice -policy "Off"

```
Automatic: Start automatically if any ports are open, and stop when all ports are closed
On: Start and stop with host
Off: Start and stop manually
```

### Stop ESXi Shell and change configurations

Get-VMHost esxihost(renomear) | Foreach { Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM"}) -Confirm:$false }
Get-VMHost esxihost(renomear) | get-vmhostservice | where-object {$_.key -eq "TSM"} | set-vmhostservice -policy "Off"

```
Automatic: Start automatically if any ports are open, and stop when all ports are closed
On: Start and stop with host
Off: Start and stop manually
```

### Power Management

$view = (Get-VMHost esxihost(renomear) | Get-View)
(Get-View $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)

```
Alterar em mais do que 1 host de VMware
$vmHosts = Get-VMHost
foreach ($vmHost in $vmHosts)
{
$view = (Get-VMHost $vmHost | Get-View)
(Get-View $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)
}
This sets the Power Policy to High Performance (1)
1=HighPerformance
2=Balanced
3=LowPower
```

## Recolha de evidências

### Q115

Get-VMHost esxihost(renomear) | Get-View | Select Name,{$_.Config.Product.FullName},{$_.Config.Product.Build} | ft -auto

### Q205

Get-VMHost esxihost(renomear) | Sort Name | %{
	$thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
	$decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
	$installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
	[pscustomobject][ordered]@{
		Name="$($_.name)"
		InstallDate=$installDate
	} # end custom object
} # end host loop