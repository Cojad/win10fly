# Windows 10 fly 清爽版&預裝 Office 2016

下載網址: https://mega.nz/#F!E4llhBgZ!wlHWnvr2OFxpxIdEIwZ74Q
##作者
柯姊 [t.me/Cojad](t.me/Cojad)

##簡介

```
Windows 10 x64 春季創作者更新繁體中文版原版iso(專業版+家用版)
+ KB4338819 Windows 1803 2018 7月累積更新
+ KB4338832 Adobe Flash 安全性更新
- 一堆沒啥用的Windows Modern App(FeedbackHub, OneConnect, 接龍, CandyCrush, Flipboard, Disney 磚 ...etc)
+ 預設桌面常用圖示(我的電腦/控制台/使用者文件/網路)
+ 補回在春季創作者更新的網芳SMBv1協定來增加舊網芳分享設備的相容性
+ 預設顯示隱藏檔, 副檔名
* 安裝過程的版權宣告, 大部分的預設選項(地區/時區), 金鑰輸入(你還是得自己處理Win授權, 如果機器已經數位授權則可以自動啟動)
* 關閉UAC提示
* (v2版本已經解決此問題)本來想要附帶自動移除OneDrive, 但是因為缺乏NTlite正版授權, post script移除又失敗, 只好請諸位高抬貴手自己去控制台
  ->新增/移除程式 手動移除吧...
```
##螢幕截圖
選項1
![選項1](screenshots/option1.png?raw=true)
選項2
![選項2](screenshots/option2.png?raw=true)
選項3
![選項2](screenshots/option3.png?raw=true)
清爽的開始
![清爽的開始](screenshots/start_clean.png?raw=true)
豐富的開始
![豐富的開始](screenshots/start_rich.png?raw=true)
預裝office(v4)
![預裝office](screenshots/start_office.png?raw=true)

##版本歷史

```
20180714 v5 清爽+豐富版+Office Win10_x64_1803_SLIM_Office_v5.iso
            改為第一次啟動輸入帳號前安裝Office2016 VLKMS版, 放棄 Click-to-Run 版本
20180713 v4 清爽+豐富版+Office Win10_x64_1803_SLIM_Office_v4.iso(未發佈)
20180713 v3 清爽+豐富版 Win10_x64_1803_SLIM_v3.iso(未發佈)
20180712 v2 移除oneDrive(未發佈)
20180712 v1 作者生日快樂版 Win10_x64_1803_SLIM.iso
```
有問題歡迎到 telegram 上的 [自己的程式自己寫](https://t.me/joinchat/DoTGVEFiQS0S0AsJola8qw) , [Happy Web Developer](https://t.me/HWDTaiwan) 這兩個群組找作者詢問

##詳細異動參見下方清單

### 手動透過wimlib異動
```
移除
  OneDrive
追加
  補回 BingNews
  增加 預裝Office 2016(v4)
安裝界面
  增加安裝選項, 並補上詳細說明(v3)
```
### NTLite異動

```
元件
  Windows Apps
    移除 FeedbackHub
    移除 Office.OneNote
    移除 OfficeHub
    移除 OneConnect
    移除 SolitaireCollection
    移除 ZuneMusic
    移除 ZuneVideo
    移除 歡迎中心(Getstarted)
功能
  增加 SMB1.0/CIFS 共用支援(為了相容舊版網芳裝置如印表機)
設定
  使用者帳戶控制
    關閉 UAC管理員
  桌面
    顯示圖示 使用者的文件
    顯示圖示 我的電腦
    顯示圖示 控制台
    顯示圖示 網路
  檔案總管
    顯示 已知檔案類型的副檔名(避免病毒偽裝圖示)
    顯示 顯示空磁碟機
    顯示 顯示隱藏的檔案/資料夾/磁碟機
    使用Windows相片檢視器, 而非照片App
  隱私權選項
    停用 新使用者自動安裝贊助商應用程式(消費者經驗 CandyCrush/Facebook..etc)
    停用 預裝的OEM應用程式
    停用 預裝的應用程式(MineCraft/CandyCrush/Flipboard磚)
整合
  核心 Windows 10 1803 春季創作者更新繁體中文版
  KB4338819 Windows 1803 2018 7月累積更新
  KB4338832 Adobe Flash Security Update
無人值守
  安裝階段WindowsPE
    語系
      輸入地區 中文繁體(美式鍵盤)
      系統地區 中文繁體 zh-TW
      使用者地區 中文繁體 zh-TW
    設定
      關閉 傳送安裝報告給微軟
      略過 EULA(版權宣告)
  OOBE(第一次啟動)
    Windows語系
      輸入地區 中文繁體(美式鍵盤)
      系統地區 中文繁體 zh-TW
      使用者地區 中文繁體 zh-TW
    Shell選項
      時區 台北+8
      略過 EULA(版權宣告)
      略過 建立線上Microsoft帳戶(僅使用本機帳戶)
後續安裝
  無
```