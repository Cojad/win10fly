# 作者: t.me/cojad
# 這不是可以直接用的script, 只是所有我曾下過得重要指令紀錄蒐集
# https://serverfault.com/questions/770686/deploying-windows-10-in-an-enterprise-how-do-i-remove-the-pre-installed-apps
# 先安裝 NTFSSecurity 才能修改某些唯獨的檔案(移除oneDrive使用)
Install-Module -Name NTFSSecurity
$wimfile = "install.wim"
$mountdir = "dir"
dism.exe /Mount-Image /ImageFile:$wimfile /Index:1 /MountDir:$mountdir

takeown /F $mountdir\Windows\SysWOW64\OneDriveSetup.exe /A
Add-NTFSAccess -Path "$($mountdir)\Windows\SysWOW64\onedrivesetup.exe" -Account "BUILTIN\Administrators" -AccessRights FullControl
Remove-Item $mountdir\Windows\SysWOW64\onedrivesetup.exe

reg load HKEY_LOCAL_MACHINE\WIM $mountdir\Users\Default\ntuser.dat
reg delete "HKEY_LOCAL_MACHINE\WIM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f

# Remove Cloud Content
reg add HKEY_LOCAL_MACHINE\WIM\SOFTWARE\Policies\Microsoft\Windows\CloudContent
reg add HKEY_LOCAL_MACHINE\WIM\SOFTWARE\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg unload HKEY_LOCAL_MACHINE\WIM

# 允許另外下載AppxBundle

Reg Load HKLM\TempImg dir\Windows\system32\config\SOFTWARE
Reg Add HKLM\TempImg\Policies\Microsoft\Windows\Appx /t REG_DWORD /f /v "AllowAllTrustedApps" /d "1"
Reg unload HKLM\TempImg

#安裝 BingNews Appx
Dism /Image:$mountdir /Add-ProvisionedAppxPackage /PackagePath:Microsoft.BingNews_4.25.11802.0_neutral_~_8wekyb3d8bbwe.AppxBundle /SkipLicense

Dism /Image:$mountdir /Remove-ProvisionedAppxPackage /PackageName:Microsoft.SkypeApp_12.13.274.0_neutral_~_kzf8qxf38zg5c
#如果要寫入
dism.exe /Unmount-Image /MountDir:$mountdir /commit
#如果要放棄
dism.exe /Unmount-Image /MountDir:$mountdir /discard

#取得目前的預設Appx
Dism /image:$mountdir /Get-ProvisionedAppxPackages



Add-AppxPackage -Path "C:\Users\user1\Desktop\MyApp.appx"
add-appxpackage –path "Microsoft.BingNews_4.25.11802.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
Remove-AppxPackage -Package "Microsoft.BingNews_4.25.11802.0_neutral_~_8wekyb3d8bbwe"

Dism /Online /Add-ProvisionedAppxPackage /PackagePath:Microsoft.BingNews_4.25.11802.0_neutral_~_8wekyb3d8bbwe.AppxBundle /SkipLicense
Dism /Image:dir /Add-ProvisionedAppxPackage /PackagePath:Microsoft.BingNews_4.25.11802.0_neutral_~_8wekyb3d8bbwe.AppxBundle /SkipLicense


wimupdate install.wim 1 "--command=delete \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"
wimupdate install.wim 1 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\def.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"
wimupdate install.wim 2 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\def.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"



# http://lab.windowswiki.info/whtc/
# https://www.ntlite.com/discussions/#/discussion/1160/changing-the-date-modified-on-install
wiminfo install.wim 1 --image-property "NAME=Windows 10 Home (Clean Start)" --image-property "DESCRIPTION=Windows 10 Home (Clean Start)"
wiminfo install.wim 1 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-家用版(清爽版)" --image-property "DISPLAYDESCRIPTION=Windows 10 家用版，移除沒用的Modern App，開始選單清爽不追加常用應用程式。"
wiminfo install.wim 1 --image-property CREATIONTIME/HIGHPART=0x01D41AF1 --image-property CREATIONTIME/LOWPART=0xB06D9880

wiminfo install.wim 2 --image-property "NAME=Windows 10 Pro (Clean Start)" --image-property "DESCRIPTION=Windows 10 Pro (Clean Start)"
wiminfo install.wim 2 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-專業版(清爽版)" --image-property "DISPLAYDESCRIPTION=Windows 10 專業版，移除沒用的Modern App，開始選單清爽不追加常用應用程式。"
wiminfo install.wim 2 --image-property CREATIONTIME/HIGHPART=0x01D41AF1 --image-property CREATIONTIME/LOWPART=0xB06D9880

wimexport install.wim 1 install.wim "Windows 10 Home (Rich Start)" "Windows 10 Home (Rich Start)"
wiminfo install.wim 3 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-家用版(豐富版)" --image-property "DISPLAYDESCRIPTION=Windows 10 家用版，移除沒用的Modern App，開始選單追加常用的應用程式，使用者不大需要從左邊的所有程式翻找常見的應用程式。"
wimupdate install.wim 3 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\rich.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"

wimexport install.wim 2 install.wim "Windows 10 Pro (Rich Start)" "Windows 10 Pro (Rich Start)"
wiminfo install.wim 4 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-專業版(豐富版)" --image-property "DISPLAYDESCRIPTION=Windows 10 專業版，移除沒用的Modern App，開始選單追加常用的應用程式，使用者不大需要從左邊的所有程式翻找常見的應用程式。"
wimupdate install.wim 4 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\rich.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"


wimexport install.wim 3 install.wim "Windows 10 Home (Rich Start) + Office 2016" "Windows 10 Home (Rich Start) + Office 2016"
wiminfo install.wim 5 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-家用版+Office 2016 Pro" --image-property "DISPLAYDESCRIPTION=Windows 10 家用版，移除沒用的Modern App，開始選單追加常用的應用程式，使用者不大需要從左邊的所有程式翻找常見的應用程式。預裝Office 2016 專業版。"
wimupdate install.wim 5 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\office.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"

wimexport install.wim 4 install.wim "Windows 10 Pro (Rich Start) + Office 2016" "Windows 10 Pro (Rich Start) + Office 2016"
wiminfo install.wim 6 --image-property "DISPLAYNAME=Win10 1803+1807累積更新-專業版+Office 2016 Pro" --image-property "DISPLAYDESCRIPTION=Windows 10 專業版，移除沒用的Modern App，開始選單追加常用的應用程式，使用者不大需要從左邊的所有程式翻找常見的應用程式。預裝Office 2016 專業版。"
wimupdate install.wim 6 "--command=add \Users\Default\AppData\Local\Microsoft\Windows\Shell\office.xml \Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"

wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\Access 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\Access 2016.lnk'" --no-acls
wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\Excel 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\Excel 2016.lnk'" --no-acls
wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\Outlook 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\Outlook 2016.lnk'" --no-acls
wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\PowerPoint 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\PowerPoint 2016.lnk'" --no-acls
wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\Publisher 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\Publisher 2016.lnk'" --no-acls
wimupdate .\install.wim 6 "--command=add '\programdata\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk' '\programdata\Microsoft\Windows\Start Menu\Programs\Word.lnk'" --no-acls

# https://github.com/Tsusai/Tool-Office365-Offline-Installer/blob/master/bin/Setup/2016_ProductIDs.txt
# https://blogs.technet.microsoft.com/ausoemteam/2016/02/23/office-v16-opk-for-office-2016-available-from-the-oem-partner-center/
# https://devicepartner.microsoft.com/zh-tw/assets/detail/X21-79723-zip
# cojad@timastitan.onmicrosoft.com
# https://www.hkepc.com/forum/viewthread.php?fid=294&tid=2231154
# https://www.icka.org/637/轉如何下載包含最新補丁的office-2013安裝包
dism.exe /Mount-Image /ImageFile:$wimfile /Index:5 /MountDir:$mountdir
dism.exe /Mount-Image /ImageFile:$wimfile /Index:6 /MountDir:$mountdir
DISM /Image:$mountdir /Add-ProvisionedAppxPackage /PackagePath=OPK165\shared.PreinstallKit\shared.appxbundle /OptionalPackagePath=OPK165\excel.PreinstallKit\excel.appxbundle /OptionalPackagePath=OPK165\powerpoint.PreinstallKit\powerpoint.appxbundle /OptionalPackagePath=OPK165\word.PreinstallKit\word.appxbundle /OptionalPackagePath=OPK165\outlook.PreinstallKit\outlook.appxbundle /OptionalPackagePath=OPK165\publisher.PreinstallKit\publisher.appxbundle /OptionalPackagePath=OPK165\access.PreinstallKit\access.appxbundle /LicensePath=OPK165\shared.PreinstallKit\shared_License1.xml /LicensePath=OPK165\excel.PreinstallKit\excel_License1.xml /LicensePath=OPK165\powerpoint.PreinstallKit\powerpoint_License1.xml /LicensePath=OPK165\word.PreinstallKit\word_License1.xml /LicensePath=OPK165\outlook.PreinstallKit\outlook_License1.xml /LicensePath=OPK165\publisher.PreinstallKit\publisher_License1.xml /LicensePath=OPK165\access.PreinstallKit\access_License1.xml
dism.exe /Unmount-Image /MountDir:$mountdir /commit

cscript.exe 'C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS' /dstatus
cscript.exe 'C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS' /sethst:ass.tw
cscript.exe 'C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS' /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
cscript.exe 'C:\Program Files (x86)\Microsoft Office\Office16\OSPP.VBS' /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99