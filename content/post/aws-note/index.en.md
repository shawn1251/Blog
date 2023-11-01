---
title: "AWS Note"
date: 2023-10-31T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["devops"]
tags: ["devops", "aws"]
---

I'm currently studying [DevOps Beginners to Advanced with Projects](https://www.udemy.com/course/decodingdevops/#reviews) on Udemy. Here are some notes on using AWS:

## Creating an EC2 Instance
The most basic computing unit:

* Name and Tag
    * Here, you can choose to "add additional tags" to provide extra labels for easy identification on the AWS console.
* AMI (Amazon Machine Image)
    * An AMI is like an image, similar to running a Docker image to create a container, but here, you create an EC2 instance.
* Instance Type
    * For the free tier, I've only used t2.micro. In real scenarios, you can choose different resource levels based on your requirements.
* Key Pair
    * AWS uses SSH keys for remote access. Choose the key pair for this instance. You can reuse a key pair across different instances for better key pair management.
* Network Settings
    * Configure inbound and outbound rules. Typically, you'd open inbound for SSH and add "my IP" as the source. For web services, you'd add HTTP with a source of "anywhere."
* Configure Storage
    * AWS offers various storage types, such as SSD, HDD, and specialized types based on I/O.
* Advanced
    * Here, I used the "User Data" field. You can write shell scripts in this field to install software or complete specific configurations during instance launch.

## Elastic Block Store (EBS)
Storage options:

* Volume Type
    * You can choose storage types like SSD, HDD, or specialized types based on I/O.
    * You can also select the region for volume creation.
* AWS allows dynamic attachment of volumes to instances.
    * Use `fdisk -l` to check the volume's name.
    * Use `fdisk /dev/xvdf` to create partitions. The path might vary based on the previous command's output.
        * `m` for help
        * `n` new partition
        * `p` primary
        * partition number: default
        * First sector: default
        * Last sector: default
        * `w` write table to disk
    * Create partitions, format them using `mkfs.ext4`, and check with `lsblk`.
    * Mount the partition using `mount /dev/xvdf1 {target path}`. To make it auto-mount, modify `/etc/fstab`.
* Snapshot
    * Important data, like a database, is often stored on a separate volume.
    * You can use EBS snapshots to back up a volume and later restore it by creating a new volume from the snapshot.

## Load Balancing
An example with two instances running the same HTTP server:

* Create a Target Group
    * Configure health checks to ensure instance health. For a web server, set up periodic HTTP requests to a specific path.
    * Add instances to the target group.
* Create a Load Balancer
    * For example, use an Application Load Balancer.
    * Configure security groups for inbound HTTP traffic.
    * Set up listeners & routing to forward traffic to the target group.
* Adjust the security group of the target group to allow access from the load balancer's security group.

## CloudWatch
Create alarms, such as monitoring CPU resources:

* Go to "All Alarms" and create a new alarm.
* Select metrics, e.g., EC2, per-instance metrics.
* Choose the instance ID and select CPUUtilization.
* Set the threshold (e.g., 60%) and configure notification details for email or groups.

## Amazon Elastic File System (EFS)
Similar to NFS on Linux, suitable for shared storage among multiple instances:

* Create a security group for EFS.
    * Create an EFS file system with default performance settings or adjust as needed.
    * Configure network settings with the security group for all availability zones.
* Create an access point.
    * Mount EFS from an EC2 instance using the amazon-efs-utils. `sudo yum install -y amazon-efs-utils`. [official doc](https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html)
    * Update `/etc/fstab`
        * Add `{file-system-id}:/ {efs-mount-point} efs _netdev,noresvport,tls,accesspoint={access-point-id} 0 0`
        * [official doc](https://docs.aws.amazon.com/efs/latest/ug/automount-with-efs-mount-helper.html)
    * execute` mount -fav`.
    * If you see {mount-point}: successfully mounted, you're done.