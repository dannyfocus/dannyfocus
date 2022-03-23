Get-VMHost -PipelineVariable esx |
ForEach-Object -Process {
  $esxcli = Get-EsxCli -VMHost $esx -V2
  $esxcli.network.vswitch.standard.list.Invoke() |
  ForEach-Object -Process {
    $vss = $_
    $vss.Uplinks | where{$_ -ne $null} | %{
        $nic = $_
        $esxcli.network.nic.get.Invoke(@{nicname="$_"}) |
        Select @{N='VMHost';E={$esx.Name}},
            @{N='Switch';E={$vss.Name}},
            @{N='NIC';E={$nic}},
            LinkStatus
    }
  }
  $esxcli.network.vswitch.dvs.vmware.list.Invoke() |
  ForEach-Object -Process {
    $vds = $_
    $vds.Uplinks | where{$_ -ne $null} | %{
        $nic = $_
        $esxcli.network.nic.get.Invoke(@{nicname="$_"}) |
        Select @{N='VMHost';E={$esx.Name}},
            @{N='Switch';E={$vds.Name}},
            @{N='NIC';E={$nic}},
            LinkStatus
    }
  }
} | Format-Table -AutoSize
$vds | Export-Csv -path C:\Users\user\Desktop\New folder\teste.csv -NoTypeInformation -UseCulture