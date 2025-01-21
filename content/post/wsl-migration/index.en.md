---
title: "WSL Migration"
date: 2025-01-21T11:24:10-0800
draft: false
description: ""
type: "post"
categories: ["other"]
tags: []
---
# WSL Migration
After using WSL for a while, it can become bloated as more packages are installed. Since the C drive on my current computer is relatively small, I need to move WSL from its default location.

## WSL Location
Run this command in PowerShell to find the WSL virtual machine file. Replace `<name>` with the name of your WSL distribution, mine is `Ubuntu`:

`
(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq '<name>' }).GetValue("BasePath") + "\ext4.vhdx"
`

## Migration
Based on [this post](https://superuser.com/questions/1550622/move-wsl2-file-system-to-another-drive/1804204#1804204) by [jayesh-vachhani](https://superuser.com/users/1263491/jayesh-vachhani), I confirmed that this method works.

### Export Ubuntu
```
mkdir D:\backup
wsl --export Ubuntu D:\backup\ubuntu.tar
```

### Unregister Existing WSL
```
wsl --unregister Ubuntu
```

### Import
```
mkdir D:\wsl
wsl --import Ubuntu D:\wsl\ D:\backup\ubuntu.tar
```
WSL migration is complete, and you can now start it!

## Change Default User
WSL is now usable, but you may notice that the default login user is root. You need to change it:
```
cd C:\Users\<your user>\AppData\Local\Microsoft\WindowsApps
ubuntu config --default-user <ubuntu-username>
```