---
title: "vagrant note"
date: 2023-10-28T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["devops"]
tags: ["vm", "vagrant", "devops"]
---


Vagrant is a command line tool that makes it easy to automate the setup and launching of virtual machines (VMs). It's not a hypervisor itself but operates as a layer on top of existing hypervisors, allowing users to quickly create VMs on those hypervisors. Vagrant doesn't require an operating system image; the image (referred to as a "box") specified in the Vagrantfile is fetched from Vagrant Cloud. You define the necessary parameters in the Vagrantfile, and then you can start the VM with the `vagrant up` command.

## Common Commands
* vagrant init {box name} - Initialize a new Vagrant environment with the specified box.
* vagrant up - Start the VM.
* vagrant ssh - Log in to the VM via SSH.
* vagrant halt - Stop the VM.
* vagrant destroy - Remove the VM.

## Process
* Create a folder.
* Create a Vagrantfile.
* Run vagrant up to start the VM.
* Use vagrant ssh to access the VM.
* Stop or delete the VM with vagrant halt or vagrant destroy.

## Example
You can find VM images (boxes) on Vagrant Cloud: https://app.vagrantup.com/boxes/search. Initialize a new Vagrant environment with a specific box using vagrant init {box name} and start it with vagrant up. You can check the status of your VMs with vagrant global-status.

```bash!
vagrant init {box name}
vagrant up
vagrant global-status
```


## Provision of Vagrantfile
Provisioning allows you to run commands on the VM before its first boot, such as installing specific software. You can refer to the official Vagrantfile documentation for more details. Here's an example of provisioning to install Apache2 during VM setup:

```vagrantfile!
# Example provisioning to install Apache2 during VM setup

config.vm.provision "shell", inline: <<-SHELL
  apt-get update
  apt-get install -y apache2
SHELL
```