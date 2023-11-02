---
title: "AWS 筆記-專案轉移至雲端"
date: 2023-11-02T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["devops"]
tags: ["devops", "aws"]
---

最近在 Udemy 上學習 [DevOps Beginners to Advanced with Projects](https://www.udemy.com/course/decodingdevops/#reviews)。在此做一些關於 AWS 使用上的筆記。


## Original Application Stack
[專案github](https://github.com/hkhcoder/vprofile-project/tree/aws-LiftAndShift)
* Nginx
* Apache
* Tomcat
* RabbitMQ
* Memcache
* Mysql
{{< figure src="images/origin-arch.drawio.png" width="30%" >}}
## 移轉目標
* EC2
    * vm for tomcat, rabbitmq,memcache, mysql
* ELB
    * nginx load balancer 
* Autoscaling
    * automation for vm scaling
* S3/EFS
    * shared storage
* route53
    * private dns service
### 目標架構圖
{{< figure src="images/shift-aws-arch.drawio.png" width="70%" >}}


## flow of execution
1. Create key pairs
2. Create security groups
    * 此處切為三組: 
        * LB(取代nginx)
        * APP(tomcat)
        * Backend(包含rabbitmq, memcache, mysql) 
3. Launch instance with user data
    * 目前還是半自動化的流程
    * 手動建立intance並且於userdata中貼上環境安裝設定的shell
4. Update ip to name mapping in route53
    * 這邊設定一個內部DNS，讓instance之間的溝通可以用hostname
5. Build application from source code
    * 這邊仍是半自動化的部分，我們在local端將java的專案build完畢
6. Upload to S3 bucket
    * 使用aws cli上傳build的java war至APP instance
7. Download artifact to Tomcat EC2 instance
    * 之前在local端是使用key的方式來連接s3
    * 此處instance連接S3練習使用IAM role
        * 於IAM建立新的S3 access role
        * 於APP instance中加入建立的role
        * `aws s3 ls`即可確認是否通過
8. Setup ELB with https(cert from amazon certificate manager)
    * 建立target group
        * 須注意這邊是要通向app的8080port
    * 建立LB
        * 設定listen HTTP/HTTPS routing 至 target group
        * 購買網域後於aws的certificate manager申請ssl cert
        * secure listener 選用from ACM，使用剛剛的ssl cert
9. Map ELB endpoint to website name in DNS
    * 於DNS提供商(此處是用godaddy)，建立CNAME，並轉向AWS LB的domain
10. Verify
    * DNS的設定通常會需要一點時間
    * 可以直接先access LB的domain檢查80有沒有APP出現
11. Build autoscaling group for tomcat instance
    * autoscaling三個步驟
        * AMI
            * 此處我們以app作為目標，將當前的app instance create image
        * launch template
            * 使用剛建立的AMI，security group 與原本的APP相同
        * autoscaling group
            * attach to existing load balancer
            * 選擇load balancer使用的target group
            * 設定scaling policy，可以使用CPU用量或是network in/out
            * 設定notification
    