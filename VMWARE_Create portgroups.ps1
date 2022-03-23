#criar portgroup no host de VMware
#Get-VMHost "host de vmware" | Get-VirtualSwitch -name nome do virtual switch | New-VirtualPortGroup -name  "nome da vlan" -VLANId ID da vlan
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN121-Database-Replication" -VLANId 121
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN123-Database-Replication" -VLANId 123
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN119-Database-Frontend" -VLANId 119
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN120-Database-Frontend" -VLANId 120
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN118-Database-Frontend" -VLANId 118
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN122-Database-Replication" -VLANId 122
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN117-Database-Frontend" -VLANId 117
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1419-V-DATZ-BKP" -VLANId 1419
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1418-V-DATZ-IFR" -VLANId 1418
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1417-V-DATZ-FRE" -VLANId 1417
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1420-V-DATZ-TRF" -VLANId 1420
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1421-V-DATZ-REP" -VLANId 1421
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN630-Database-Backup" -VLANId 630
Get-VMHost "sppt1piesx104.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN124-Database-Replication" -VLANId 124