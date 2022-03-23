#script para novo host

$Newhost = Read-Host "Enter FQDN of new host"

#Correr no vcenter

#Configuração SysLog
Get-AdvancedSetting -Entity $Newhost -Name "VMFS3.UseATSForHBOnVMFS5" | Set-AdvancedSetting -Value "0" | ft -auto
Get-AdvancedSetting -Entity $Newhost -Name "Syslog.global.logHost" | Set-AdvancedSetting -Value "udp://10.80.21.63:514" | ft -auto
Get-AdvancedSetting -Entity $Newhost -Name "Syslog.global.logDirUnique" | Set-AdvancedSetting -Value "true"  | ft -auto
Get-AdvancedSetting -Entity $Newhost -Name "Syslog.global.logDir" | Set-AdvancedSetting -Value "[esxihost(renomear)_001_r1_internal] Log" | ft -auto
Get-VMHost -Name $Newhost | Get-VMHostFirewallException | where {$_.Name -eq "syslog"} | Set-VMHostFirewallException -Enabled $true -Confirm:$false

#Configuração NTP
Get-VMHost $Newhost | Add-VMHostNtpServer -NtpServer "10.80.102.1" , "10.105.86.1" | ft -auto

#Start NTP client service and set to automatic
Get-VmHostService -VMHost $Newhost | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VmHostService -VMHost $Newhost | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
Get-VMHostFirewallException -VMHost $Newhost | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true

#Configuração Time COnfiguration
Get-VMHost $Newhost | Get-VMHostService | where {$_.Key -eq "ntpd"} |Set-VMHostService -Policy "on"

#validar estado do NTP
Get-VMHost $Newhost | Get-VmHostService | Where-Object {$_.key -eq "ntpd"}

#Password Complexity
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'Security.PasswordQualityControl' | Set-AdvancedSetting -value "retry=3 min=disabled,disabled,disabled,15,15"

#BUN
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'Annotations.WelcomeMessage' | Set-AdvancedSetting -value "Insert BUN here"
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'Config.Etc.issue' | Set-AdvancedSetting -value "Insert BUN here"

#Account Unlock Time
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'Security.AccountUnlockTime' | Set-AdvancedSetting -value "120"

#Account
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'Security.AccountLockFailures' | Set-AdvancedSetting -value "10"

#ESXi Shell and SSH idle session timeout
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'UserVars.ESXiShellTimeOut' | Set-AdvancedSetting -value "600"
Get-VMHost $Newhost | Get-AdvancedSetting -Name 'UserVars.ESXiShellInteractiveTimeOut' | Set-AdvancedSetting -value "14400"


#Stop SSH and change configurations
Get-VMHost $Newhost | Foreach {  Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"}) -Confirm:$false }
Get-VMHost $Newhost | get-vmhostservice | where-object {$_.key -eq "TSM-SSH"} | set-vmhostservice -policy "Off"
<#Automatic: Start automatically if any ports are open, and stop when all ports are closed
On: Start and stop with host
Off: Start and stop manually
#>

#Stop ESXi Shell and change configurations
Get-VMHost $Newhost | Foreach {  Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM"}) -Confirm:$false }
Get-VMHost $Newhost | get-vmhostservice | where-object {$_.key -eq "TSM"} | set-vmhostservice -policy "Off"
<#Automatic: Start automatically if any ports are open, and stop when all ports are closed
On: Start and stop with host
Off: Start and stop manually
#>

#Power Management
$view = (Get-VMHost $Newhost  | Get-View)
(Get-View $view.ConfigManager.PowerSystem).ConfigurePowerPolicy(1)
<#
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
#>

#Criar array com os valores necessários no acto da instalação
#Criar vSwitch
New-VirtualSwitch -VMHost $Newhost -Name vSwitch1 -nic vmnic4,vmnic5 -mtu 1500

#Criar portgroups
Get-VMHost "$Newhost" | Get-VirtualSwitch -name vSwitchx | New-VirtualPortGroup -name  "VLANXXX-Database" -VLANId 1.2.3

#Reservar Raw Devices
$vmHosts = get-cluster "CLUSTER_PROD" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,	"naa.LUNID(ID do raw device em minusculas)",$true)

#Recolha de evidências
#Q115
Get-VMHost "$Newhost"  | Get-View |  Select Name,{$_.Config.Product.FullName},{$_.Config.Product.Build} | ft -auto
#Q205

Get-VMHost "$Newhost" | Sort Name | %{
   $thisUUID = (Get-EsxCli -VMHost $_.name).system.uuid.get()
   $decDate = [Convert]::ToInt32($thisUUID.Split("-")[0], 16)
   $installDate = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($decDate))
   [pscustomobject][ordered]@{
     Name="$($_.name)"
     InstallDate=$installDate
   } # end custom object
} # end host loop


#criar uma pausa
Pause

#Correr no host

#$Newhost = Read-Host "Enter FQDN of new host"
$newdatastore = Read-Host "Enter datastore name"

#Criar users
New-VMHostAccount -Id USER1 -password PASSWORD -Description "Description"
New-VMHostAccount -Id USER2 -password PASSWORD -Description "Description"

#Alteração da descrição dos users
Set-VMHostAccount -UserAccount "vpxuser" -Description "Description" | ft -auto
Set-VMHostAccount -UserAccount "dcui" -Description "Description" | ft -auto
Set-VMHostAccount -UserAccount "root" -Description "Description" | ft -auto

#validar users
Get-VMHostAccount | ft -auto

#Renomear Datastores
Get-Datastore -name $newdatastore | Set-Datastore -name $newdatastore+"_001_r1_internal"

#Criar pasta Log
$datastore = Get-Datastore -Name $newdatastore
New-PSDrive -Location $datastore -Name DS -PSProvider VimDatastore -Root "\"
New-Item -Path DS:\Log -ItemType Directory
Remove-PSDrive -Name DS -Confirm:$false
