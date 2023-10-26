---
title: '安裝chocolatey'
date: 2023-10-24T06:42:46+08:00
draft: false
categories: ["other"]
tags: ["tool", "windows"]
---

chocolatey 是windows上一個安裝軟體的工具。我以前都是使用macOS為主，chocolatey就像是mac上的brew一樣。有了他，安裝軟體變得方便許多。

## 安裝

```powershell
Get-ExecutionPolicy
# 若為 restricted，以系統管理員執行powershell後輸入以下指令
Set-ExecutionPolicy AllSigned
# 輸入Y or A 完成權限設定
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# 最後執行`choco`來確認是否有安裝成功
choco
```

## 使用
我們可以前往 https://community.chocolatey.org/packages 網站上搜尋目標的軟體
好比我們搜尋virtual box，就可以看見他將指令寫在後方 
```powershell
choco install virtualbox
```
執行指令後就會自動安裝了!