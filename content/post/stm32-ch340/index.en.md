---
title: "Flashing STM32 with CH340"
date: 2023-11-20T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["embedded"]
tags: ["embedded", "stm32", "CH340"]
---

Recently, I've been learning embedded development with STM32. However, since I don't have STLINK, I have to use CH340 for flashing. Here's a quick overview of the process.

## Required Software
* Keil5
* FlyMcu
## Steps
* CH340 Pinout:
    * VCC: Jumper cap for setting 5V/3.3V
    * RX: Connects to GPIO PA09 for receiving
    * TX: Connects to GPIO PA10 for transmitting
    * GND: Ground connection
* For flashing, a hex file is needed. So, in my IDE Keil5, additional settings are required.

    * Click the magic wand icon (options for target).
    * Output > create hex file.
    * After building, the hex file will appear in the Objects folder.
* The flashing software used here is FlyMcu. Below are the flashing steps:

    * Plug in CH340 and ensure that the COM port above is for our CH340.
    * Code file for online ISP > Choose the built hex file.
    * Check Verify, Run After ISP complete.
    * Uncheck Program OptionBytes when ISP.
    * Click Start ISP.
* If the message on the right side shows the following, it indicates success:

    ```
    ....
    Write 1KB Ok,100%,@1562ms
    Go from 08000000 Ok
    ```
* If you want to flash a new program, press the reset button on the STM32.