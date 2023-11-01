---
title: "AWS 筆記"
date: 2023-10-31T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["devops"]
tags: ["devops", "aws"]
---

最近在 Udemy 上學習 [DevOps Beginners to Advanced with Projects](https://www.udemy.com/course/decodingdevops/#reviews)。在此做一些關於 AWS 使用上的筆記

## 建立EC2
最基本的執行單位

* Name and Tag
    * 這邊可以選用 `add additional tag`，多補充標籤，方便在aws console上可以快速搜尋指定的instance
* AMI
    * AMI 是image，有點類似docker上取用image後run成container，但在此是run 成 instance
* instance type
    * 由於目前是 free tier，只使用過 t2.micro。實際使用情境可以根據需求選擇不同等級的資源
* key pair
    * 由於aws在遠端登入時都是採用ssh key，因次在這個階段要選用此instance的key pair。
    * 方便的是一組key pair可以被重複使用在不同instance上。可因應實際使用作key pair管理
* network setting
    * 主要在建立進出規則
    * 通常會打開的in bound是ssh，source的部分可以加入my ip
    * 如果是網頁服務用instance，一般會加入HTTP，並且source為anywhere
* configure storage
    * storage分成很多類型。好比SSD，HDD，磁帶，也有根據IO做的特化型
*  advanced
    * 此處我使用到的是 `User data` 這一個欄位。這部分可以直接寫上shell，方便在啟動的時候就預先裝載軟體或完成相關設定

## Elastic Block Store
儲存體
* volume type
    * storage分成很多類型。好比SSD，HDD，磁帶，也有根據IO做的特化型
    * 還可以選擇建立地區
* aws 裡volume可以動態attach
    * attach 在指定的instance
    * `fdisk -l` 可以檢查該volume的名稱
    * `fdisk /dev/xvdf` 這個路徑可能有所不同，根據前一個指令取得的dev更換
        * `m` 可以檢視可用指令
        * `n` new partition
        * `p` primary
        * partition number: default 1
        * First sector: default 2048
        * Last sector: default
        * `w` write table to disk
    * `mkfs.ext4 /dev/xvdf1`: 這個指令可以根據要使用的format做更換，本處使用ext4
    * 使用 `lsblk` 檢查是否出現
    * `mount /dev/xvdf1 {target path}` 就能進行掛載
        * 如果要讓其自動掛載，請修改`/etc/fstab`。往後就能開機自動掛載也可使用`mount -a`
* snapshot
    * 通常主要的資料都會使用另外的volume，好比database的data
    * 我們可以使用 EBS 中的 snapshot 功能，為當前的volume進行備份
    * 之後一旦有需要進行還原，就可以對指定的snapshot執行create volume from snapshot，就可以將當時的內容重新掛載到instance上

## Load Balancing
以兩個執行同樣http server的instances做example

* 建立target group
    * target group 的health check用來確認instance是否正常，如果是網頁伺服器，可以設定http路徑定時對指定頁面進行請求
    * 將目標的instances拉入target group
* 建立load balancer
    * 先以 Application Load Balance 為 example
    * security group 由於是web server，要設定inbound 為 HTTP ipv4/v6 anywhere
    * listener & routing 設定為轉發到剛才創建的target group
* 回頭設定target group的security group
    * 因為剛剛並沒有設定load balancer所在的security group可以access到target group。因此要將load balancer所在的security group加入target group 的security 中。 inbound HTTP custom {sg id}


## Cloud Watch
可以用來建立警告，此處以cpu資源作作為example
* all alarm -> create alarm
* select metric -> ec2 -> pre instance metric
* 尋找目標的instance id，並選取CPUUtilization
* 在greater than..的部分設定想要的百分比，好比60
* 最後，設定通知的內容還有對象email或群組

## EFS
這有點類似我們linux上在用的NFS，適合作為多個instance共同的儲存空間
* 建立security group
    * 由於EFS是基於網路的連線，所以必須先設定security group
    * 將inbound 加入 NFS，source 為目標instance的security group
* EFS -> create file system
    * 這邊練習用的performance setting使用預設的enhanced, elastic即可。實際使用根據需求調整
    * Network setting這邊所有availability zone的security group 都選擇剛剛新建立給EFS用的security group。
* 建立access point
    * file system 選擇剛建立的file system id
* 從EC2進行mount
    * 連線EFS要一些工具，執行`sudo yum install -y amazon-efs-utils`安裝。這部分可以參考[官方文件](https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html)
    * 接下來設定/etc/fstab
        * 加入這一行 `{file-system-id}:/ {efs-mount-point} efs _netdev,noresvport,tls,accesspoint={access-point-id} 0 0`
        * 可參考[官方文件](https://docs.aws.amazon.com/efs/latest/ug/automount-with-efs-mount-helper.html)
    * 執行`mount -fav`。若出現 {mount-point} : successfully mounted，就完成了

