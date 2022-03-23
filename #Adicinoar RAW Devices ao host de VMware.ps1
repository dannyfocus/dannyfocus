#Adicinoar RAW Devices ao host de VMware
#Lisboa
$vmHosts = get-cluster "CLUSTER10_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,	"naa.600507680C808312A000000000000F59",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.600507680C808312A000000000000F5A",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.600507680C808312A000000000000F5B",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.600507680C808312A000000000000F5C",	$true)


#Porto
$vmHosts = get-cluster "CLUSTER10_PROD_GS" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,	"naa.60050768018107A508000000000004CC",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.60050768018107A508000000000004CD",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.60050768018107A508000000000004CE",	$true)
$myesxcli.storage.core.device.setconfig($false,	"naa.60050768018107A508000000000004CF",	$true)

$vmHosts = get-cluster "CLUSTER24_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000031", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000032", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000033", $true)

$vmHosts = get-cluster "CLUSTER24_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000034", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000035", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000036", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000037", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000038", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000039", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003a", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003b", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003c", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003d", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003e", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad40000000000003f", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000040", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000041", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000042", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000043", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000044", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000045", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000046", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000047", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507638081025ad400000000000048", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507680c808312a000000000000d74", $true)
$myesxcli.storage.core.device.setconfig($false,"naa.600507680c808312a000000000000d75", $true)

$vmHosts = get-cluster "CLUSTER10_PROD_TP" | get-vmhost
$myesxcli = Get-EsxCli -VMHost $vmhosts
$myesxcli.storage.core.device.list()|select Device,IsPerenniallyReserved|where {$_.Device -like  "*600507638081025ad400000000000031*"}






<#
Get-VMHost "sppt1peesx201.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN317 - V-DATZ-FRE" -VLANId 317
Get-VMHost "sppt1peesx201.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN318 - V-DATZ-IFR" -VLANId 318
Get-VMHost "sppt1peesx201.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN319 - V-DATZ-BKP" -VLANId 319
Get-VMHost "sppt1peesx201.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN320 - V-DATZ-TRF" -VLANId 320
Get-VMHost "sppt1peesx201.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN321 - V-DATZ-REP" -VLANId 321

Get-VMHost "SPPT1PEESX202.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN317 - V-DATZ-FRE" -VLANId 317
Get-VMHost "SPPT1PEESX202.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN318 - V-DATZ-IFR" -VLANId 318
Get-VMHost "SPPT1PEESX202.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN319 - V-DATZ-BKP" -VLANId 319
Get-VMHost "SPPT1PEESX202.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN320 - V-DATZ-TRF" -VLANId 320
Get-VMHost "SPPT1PEESX202.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN321 - V-DATZ-REP" -VLANId 321

Get-VMHost "SETPIZIESX25.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN317 - V-DATZ-FRE" -VLANId 317
Get-VMHost "SETPIZIESX25.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN318 - V-DATZ-IFR" -VLANId 318
Get-VMHost "SETPIZIESX25.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN319 - V-DATZ-BKP" -VLANId 319
Get-VMHost "SETPIZIESX25.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN320 - V-DATZ-TRF" -VLANId 320
Get-VMHost "SETPIZIESX25.bcpcorp.net" | Get-VirtualSwitch -name vSwitch3 | New-VirtualPortGroup -name  "VLAN321 - V-DATZ-REP" -VLANId 321
#>

Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN104-I01-Core-Middleware-in" -VLANId 104
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN104-Postos_Trabalho" -VLANId 104
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN105-Bass-CoreDataRepository_FrontendsApps" -VLANId 105
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN109-Postos-PRD" -VLANId 109
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN110-I01-FlexOn_Prod" -VLANId 110
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN114-I01-Transversals-Frontends-Terminal-Servers-1" -VLANId 114
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN115-I01-Transversals-Frontends-Web-App-Gateways-1" -VLANId 115
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN116-I01-Apps-1" -VLANId 116
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1252-I25-BMC_Management" -VLANId 1252
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1253-I25-BMC_Service" -VLANId  1253
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1315-HEARTBEAT-SOPHIS" -VLANId 1315
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1402-V-IIMS-IFR" -VLANId 1402
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1403-V-IIMS-BKP" -VLANId 1403
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1404-V-IIMS-MBD" -VLANId 1401
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1405-V-PZIA-FRE" -VLANId 1405
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1406-V-PZIA-BEN" -VLANId 1406
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1407-V-PZIA-IFR" -VLANId 1407
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1408-V-PZIA-BKP" -VLANId 1408
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1412-V-APPZ-FRE" -VLANId 1412
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1413-V-APPZ-BEN" -VLANId 1413
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1414-V-APPZ-IFR" -VLANId 1414
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1415-V-APPZ-BKP" -VLANId 1415
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1416-V-APPZ-TRF" -VLANId 1416
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1422-V-INTZ-FRE" -VLANId 1422
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1423-V-INTZ-IFR" -VLANId 1423
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1424-V-INTZ-BKP" -VLANId 1424
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN1425-V-INTZ-TRF" -VLANId 1425
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN154-ILHA02-Core_Middleware_in" -VLANId 154
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN157-ILHA2-C-OSS-1" -VLANId 157
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN195-Prod-Core_ILHA2-371" -VLANId 195
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN201-Transversals-Frontends-Apps-Int" -VLANId 201
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN203-I03-TF-WFAG-1" -VLANId 203
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN221-Prod-Apps" -VLANId 221
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN250-I04-NET_DLC" -VLANId 250
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN259-Tivoli" -VLANId 259
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN261-Prod-PKI" -VLANId 261
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN272-I04-SWA-Aplic" -VLANId 272
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN273-I04-SF" -VLANId 273
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN301-I05-Transversals-Frontends-Apps-1" -VLANId 301
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN307-Prod-Core_ILHA5-108" -VLANId 307
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN310-Ilha05-Core-Backup-1" -VLANId 310
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN313-Prod-Messaging_ILHA5-114" -VLANId 313
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN322-Prod-Gestao-RSA_ILHA5-130" -VLANId 322
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN327-Prod-Webs-AppGws_ILHA5-135" -VLANId 327
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN328-Prod-Apps_ILHA5-136" -VLANId 328
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN330-Prod-Apps_ILHA5-138" -VLANId 330
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN331-Prod-Apps_ILHA5-139" -VLANId 331
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN332-Prod-Apps_ILHA5-140" -VLANId 332
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN333-Prod-AppGws_ILHA5-141" -VLANId 333
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN334-Prod-SWIFT_ILHA5-142" -VLANId 334
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN335-Prod-SWIFT_ILHA5-143" -VLANId 335
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN336-Prod-Webs-AppGws" -VLANId 336
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN339-Prod-Core_ILHA5-372" -VLANId 339
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN352-MgmtSysEvents" -VLANId 352
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN355-I06-TF-WFAG-I1" -VLANId 355
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN382-I06-VLAN0372-SS" -VLANId 382
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN405-Presentation-Intranet-Frontend" -VLANId 405
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN406-Presentation-Intranet-Backend" -VLANId 406
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN407-Presentation-Intranet-Infra" -VLANId 407
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN510-QA-Webs-AppGws" -VLANId 510
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN511-QA-Messaging" -VLANId 511
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN512-QA-Apps" -VLANId 512
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN513-QA-Backend" -VLANId 513
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN514-QA-Gestao" -VLANId 514
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN551-DEV-Transversais-Frontends" -VLANId 551
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN569-LEGACY-V370" -VLANId 569
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN570-PKI" -VLANId 570
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN601-QA-Apps_ILHA11-302" -VLANId 601
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN603-ILHA11-603-TF.WFAG" -VLANId 603
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN604-ILHA11-C-OSS-1" -VLANId 604
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN605-QA-Core_ILHA11-309" -VLANId 605
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN609-Postos-QUA" -VLANId 609
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN611-Transversals-Frontends-Apps-2" -VLANId 611
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN614-QA-Webs_ILHA11-334" -VLANId 614
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN615-QA-Apps_ILHA11-335" -VLANId 615
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN616-DEV-Transversais_Frontends" -VLANId 616
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN617-Transversals-Frontends-Apps-4" -VLANId 617
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN623-SF-Unix_Qual" -VLANId 623
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN625-Frontends-Web" -VLANId 625
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN626-Apps" -VLANId 626
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN627-Core-Servers" -VLANId 627
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN628-Corporate-Servers" -VLANId 328
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN629-Database-Servers" -VLANId 629
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN630-Database-Backup" -VLANId 630
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN650-QA-NetDLC_ILHA12-301" -VLANId 650
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN651-QA-Apps_ILHA12-302" -VLANId 651
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN656-QA-Databases_ILHA12-309" -VLANId 656
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN658-QA-Webs_ILHA12-313" -VLANId 658
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN659-QA-MgmtSysEvents_ILHA12-330" -VLANId 659
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN660-QA-Webs_ILHA12-334" -VLANId 660
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN661-QA-Apps_ILHA12-335" -VLANId 661
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN662-QA-Webs_ILHA12-336" -VLANId 662
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN663-QA-Webs_ILHA12-337" -VLANId 663
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN664-QA-Apps_ILHA12-338" -VLANId 664
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN665-QA-Apps_ILHA12-339" -VLANId 665
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN666-QA-Webs-AppGws_ILHA12-340" -VLANId 666
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN667-QA-Webs_ILHA12-341" -VLANId 667
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN668-QA-Apps_ILHA12-342" -VLANId 668
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN670-BCP-Bancadadetestes" -VLANId 670
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN700-ILHA13-TF-A-1" -VLANId 700
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN702-Prod-Webs-AppGws_ILHA13-106" -VLANId 702
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN707-ILHA13-TF-MS-1" -VLANId 707
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN70-Netw-Manag" -VLANId 70
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN800-Prod-NetDLC_ILHA15-101" -VLANId 800
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN801-Prod-Apps_ILHA15-102" -VLANId 801
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN802-MgmtSysEvents" -VLANId 802
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN804-TFA-4_ILHA15_Frontend-Apps" -VLANId 804
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN805-Prod-Webs-AppGws_ILHA15-106" -VLANId 805
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN807-Prod-Core_ILHA15-108" -VLANId 807
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN812-Prod-DirDns_ILHA15-113" -VLANId 712
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN828-Prod-Apps_ILHA15-135" -VLANId 828
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN829-Prod-Webs-AppGws_ILHA15-136" -VLANId 829
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN830-Prod-Webs-AppGws_ILHA15-137" -VLANId 830
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN831-Prod-Webs-AppGws_ILHA15-138" -VLANId 831
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN832-Prod-Apps_ILHA15-139" -VLANId 832
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN851-TeB_Summit_Prod" -VLANId 851
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN858-USERS-DataPower" -VLANId 858
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN859-MF-DataPower" -VLANId 859
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN860-DEV-DataPower" -VLANId 860
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN861-GST-DataPower" -VLANId 861
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN871-SQL_Replica-NCI" -VLANId 871
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN872-TKLM" -VLANId 872
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN877-Gst-Storage" -VLANId 877
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN902-DC-Tivoli" -VLANId 902
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN910-Prod-Apps-NCI" -VLANId 910
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN911-QA-Apps-NCI" -VLANId 911
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN915-TS-SWIFT" -VLANId 915
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN940-Prod-Apps_ILHA1" -VLANId 940
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN941-FW-Transversals.Frontends/Directories.Dns-1" -VLANId 941
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN943-FW_Mbank-HSM" -VLANId 943
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN944-Guardium" -VLANId 944
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN945-Continuous-Compliance" -VLANId 945
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN946-FW-TS-Unmanaged-Sucursais" -VLANId 946
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN951-TeB_Summit_Service" -VLANId 951
Get-VMHost "sppt1piesx244.bcpcorp.net" | Get-VirtualSwitch -name vSwitch1 | New-VirtualPortGroup -name  "VLAN983-TServer-OSIS" -VLANId 983





Get-VMHost "sppt1piesx246.bcpcorp.net" | Add-VMHostNtpServer -NtpServer "10.80.102.1" , "10.105.86.1" | ft -auto
Get-VmHostService -VMHost "sppt1piesx246.bcpcorp.net" | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VmHostService -VMHost "sppt1piesx246.bcpcorp.net" | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
Get-VMHostFirewallException -VMHost "sppt1piesx246.bcpcorp.net" | where {$_.Name -eq "NTP client"} | Set-VMHostFirewallException -Enabled:$true
Get-VMHost | Get-VmHostService | Where-Object {$_.key -eq "ntpd"}

