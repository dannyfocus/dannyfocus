#Retirar a lista de WWN's
$scope = Get-VMHost     # All hosts connected in vCenter
#$scope = Get-Cluster -Name 'MyCluster' | Get-VMHost # All hosts in a specific cluster
foreach ($esx in $scope){
Write-Host "Host:", $esx
$hbas = Get-VMHostHba -VMHost $esx -Type FibreChannel
foreach ($hba in $hbas){
$wwpn = "{0:x}" -f $hba.PortWorldWideName
Write-Host `t $hba.Device, "|", $hba.model, "|", "World Wide Port Name:" $wwpn | Out-File –FilePath HBA_List.csv
}}
