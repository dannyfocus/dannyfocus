#Listar VMs com Raw Devices
get-cluster CLUSTER_PROD | Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl

#Listar VMs com Raw Devices com output
Get-cluster CLUSTER_PROD |Get-VM | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl | export-csv –Path VM_List.csv