#Exemplo - Pode ser aplicado em qualquer situação
$esxi = @("hostesxi1.domain.loc, hostesxi2.domain.loc, hostesxi3.domain.loc, hostesxi4.domain.loc, hostesxi5.domain.loc, hostesxi6.domain.loc, hostesxi7.domain.loc,")
0..16 | foreach-object {
    $index = $_
Get-VMHost $esxi[$index] | Get-AdvancedSetting -Name 'Config.Etc.issue' | Set-AdvancedSetting -value "Insert BUN here"}