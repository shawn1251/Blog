---
title: "wsl-migration"
date: 2025-01-21T11:24:10-0800
draft: false
description: ""
type: "post"
categories: ["other"]
tags: []
---
# WSL 搬家
WSL在一段使用過後，因為套件越裝越多，會變得肥大。目前使用的電腦C槽較小，所以有了要從預設位置搬家的需求

## WSL 所在位置
在powershell中執行此指令找到WSL本身虛擬機檔案。`<name>` 為WSL的名稱，我本身是`Ubuntu`
`(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq '<name>' }).GetValue("BasePath") + "\ext4.vhdx"`

## 搬遷
根據[這篇](https://superuser.com/questions/1550622/move-wsl2-file-system-to-another-drive/1804204#1804204)的[jayesh-vachhani](https://superuser.com/users/1263491/jayesh-vachhani)回覆，操作後確認此作法有效。
### 匯出 Ubuntu
```
mkdir D:\backup
wsl --export Ubuntu D:\backup\ubuntu.tar
```
### unregister 既有 WSL
```
wsl --unregister Ubuntu
```

### 匯入
```
mkdir D:\wsl
wsl --import Ubuntu D:\wsl\ D:\backup\ubuntu.tar
```
完成WSL搬家，可以啟動了!

## 修改預設使用者
目前WSL已經能夠使用，但會發現預設登入的使用者是root，需要進行修改
```
cd C:\Users\<your user>\AppData\Local\Microsoft\WindowsApps
ubuntu config --default-user <ubuntu-username>
```

