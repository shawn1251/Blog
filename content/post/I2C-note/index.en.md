---
title: "I2C Note"
date: 2023-11-23T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["embedded"]
tags: ["embedded", "I2C"]
---


* I2C communication uses two lines, unlike TX and RX. I2C has only one line called SDA for data transmission and another line called SCL for clock pulses.
    * SDA (serial data): carries the actual data.
    * SCL (serial clock): provides clock pulses.
* Half-Duplex
    * Unlike full-duplex communication where TX and RX can transmit and receive simultaneously, I2C allows only one side to transmit at a time, making it half-duplex.
* Master-Slave Mode
    * Only one side can send a signal at a time to avoid conflicts, so communication is initiated by the master, and the slave responds after receiving the message.
    * Multiple slaves can exist.
* Bus Protocol
    * I2C is a bus protocol that enables communication between multiple devices.
    * The master includes the target device's address at the beginning of the message. Other slaves discard the message if it's not meant for them.
* Synchronous Communication
    * In asynchronous communication, both sides have their own clocks and communicate based on the agreed Baud Rate.
    * Some small sensors lack accurate crystals for clocks, so the master's SCL provides clock pulses to all slaves.