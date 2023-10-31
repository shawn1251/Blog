---
title: "vagrant 筆記"
date: 2023-10-28T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["devops"]
tags: ["vm", "vagrant", "devops"]
---


一個command line tool方便自動化啟動VM。vagrant本身不是hypervisor，而是基於hypervisor上的一層應用，令使用者可以利用他快速架設VM於hypervisor上。本身也不需要OS image，設定檔Vagrantfile中指定的image(box)會從vagrant cloud取用。在Vagrantfile中定義所需要的參數，即可使用`vagrant up`啟動
## 常用指令
* vagrant init {box name}
* vagrant up
* vagrant ssh
* vagrant halt
* vagrant destroy

## 流程
1. create folder
2. create Vagrantfile
3. vagrant up
4. vagrant ssh
5. vagrant halt/destroy

## 啟動範例
請在這邊找尋自己想要啟動的 box https://app.vagrantup.com/boxes/search
```bash!
vagrant init {box name}
vagrant up
vagrant global-status
```

## Vagrantfile 的 provision
Vagrantfile 中有一段 provision，可以用於設定vm第一次啟動前要執行的指令，好比安裝指定的軟體。可以參考官方對Vagrantfile的說明
```vagrantfile!
# 這邊以在provision階段安裝apache2 server為例

   config.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y apache2
   SHELL
```