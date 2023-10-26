---
title: '設定github page'
date: 2023-10-21T06:42:46+08:00
draft: false
categories: ["other"]
tags: ["hugo"]
---

本篇文章用來記錄這次以Hugo建立Blog後發佈到GitHub Page的過程。
GitHub本身有個免費的個人網站服務稱作GitHub Page。只要將想要發布的網頁內容上傳到指定格式的repository即可。
## 事前準備
1. [GitHub 帳號](https://github.com/signup)
2. [安裝 git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. 你的目標網站

## 建立
1. 點擊repository，New
2. 在repository name這個欄位填入"{你的帳號}".github.io
3. 點擊 create repository

## 上傳
接下來我們就要將本地端的網站推送到github上，若沒有網站僅是想要做測試，可以簡單建立一個`index.html`做測試
```bash
# 為當前網站建立git
git init
# 加入stage並commit
git add .
git commit -m "first commit"
# 建立main分支
git branch -M main
# 將遠端repository加入設定並命名為origin
git remote add origin https://github.com/{你的帳號}/{你的帳號}.github.io.git
# 將當前專案push到github上
git push -u origin main
```

## 檢視
正常的話，前往`https://{你的帳號}.github.io`就能看到剛才推上去的網頁了! 

## 以Hugo為例，建立網站並上傳
承接上一篇[以Hugo建立第一篇Post]({{< ref "first-post" >}})，我們可以利用GitHub Page對成果進行發布。
記得更改config中的baseURL
```bash
# build
hugo
# 進入靜態網站的資料夾
cd public
# 承上說明不贅述
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/{你的帳號}/{你的帳號}.github.io.git
git push -u origin main
```