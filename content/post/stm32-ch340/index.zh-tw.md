---
title: "使用CH340燒錄程式到STM32"
date: 2023-11-20T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["embedded"]
tags: ["embedded", "stm32", "CH340"]
---

最近在用STM32學習嵌入式開發。但由於沒有STLINK，我這邊只能使用CH340燒錄。這邊記錄了一下過程。

## 需求軟體
* Keil5
* FlyMcu
## 步驟
* CH340有幾個針腳
    * VCC: 這有一個跳線帽，可以設定5V/3.3V
    * RX: 接收，接在GPIO的PA09
    * TX: 發送，接在GPIO的PA10
    * GND: 接地
* 燒錄需要的是hex檔，所以在我的IDE Keil5上要額外設定
    * 點擊魔術棒的icon(options for target)
    * Output > create hex file
    * 之後在build後，hex file會出現在Objects資料夾中
* 這邊使用的燒錄軟體是FlyMcu，以下是燒錄步驟
    * 插上CH340後，確認上方的port com為我們的CH340
    * Code file for online ISP > 選擇build好的hex file
    * 勾選 Verify, Run After ISP complete
    * 取消勾選 Program OptionBytes when ISP
    * 接著就能點擊 Start ISP
    * 如果右側訊息出現下方訊息表示成功
        ```
        ....
        Write 1KB Ok,100%,@1562ms
        Go from 08000000 Ok
        ```
* 如果要再燒錄新的program，要按一下stm32上的reset按鈕