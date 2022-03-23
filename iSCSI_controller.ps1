#recolha de máquians com controladora iscsi
Get-VM | Get-ScsiController | select Parent, BusSharingMode, Type | Out-File –FilePath path\iscsi_List.csv