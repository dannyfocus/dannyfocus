#Novo raw device
New-HardDisk -VM SVPT1PEQNO011 -DiskType RawPhysical -DeviceName /vmfs/devices/disks/naa.600507680c808312a0000000000004f3 -Controller "SCSI controller 1"


#Novo disco
New-HardDisk -VM SVPT1PEQNO012	-DiskPath "[cluster10-dmz-i-tp_190_flash] SVPT1PEQNO011/SVPT1PEQNO011_2.vmdk" -Controller "SCSI controller 1"