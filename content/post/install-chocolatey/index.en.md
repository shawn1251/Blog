---
title: 'Install chocolatey'
date: 2023-10-24T06:42:46+08:00
draft: false
categories: ["other"]
tags: ["tool", "windows"]
---

Chocolatey is a software installation tool for Windows, similar to 'brew' on macOS. It makes installing software much more convenient.

## Installation
```powershell
Get-ExecutionPolicy
# If it's 'restricted,' run PowerShell as an administrator and enter the following commands:
Set-ExecutionPolicy AllSigned
# Enter Y or A to confirm the permission change.
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Finally, run `choco` to confirm a successful installation.
choco
```

## Usage
You can visit https://community.chocolatey.org/packages to search for the software you want. For example, if you're looking for VirtualBox, you'll find the command:

```powershell
choco install virtualbox
```

Running this command will automatically install the software!