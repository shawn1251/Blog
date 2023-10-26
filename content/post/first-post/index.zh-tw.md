---
title: "First Post with Hugo"
date: 2023-10-20T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["other"]
tags: ["hugo"]
---

這次心血來潮決定將一些過往的筆記進行整理，在尋找平台的時候參考了友人的建議選擇了Hugo搭配github page。以下就來記錄一下過程。

# Hugo
簡單介紹一下Hugo， [Hugo](https://gohugo.io/) 是用Golang開發的靜態網站產生工具。靜態網站不依賴後端，速度快又不必架設資料庫，特別適合開發展示用的網站。以前很流行使用wordpress架設個人網站，
相較於這種功能豐富的CMS，若需求單純，其實更加推薦使用靜態網站，同樣類型的工具還有 [Hexo](https://hexo.io/) 與 [Jekyll](https://jekyllrb.com/)。

Hugo的本身由Golang開發，所以我們在使用的時候僅需要安裝編譯好的Hugo執行檔，不用再安裝其他相依語言如ruby、js。我們可以先瀏覽一下別人建立好的 [Hugo template](https://themes.gohugo.io/tags/blog) 想像一下之後的作品效果。

## installation
我們這邊參照官方的教學 https://gohugo.io/getting-started/quick-start/

### 安裝Hugo
請根據自己的作業系統選擇 [安裝方法](https://gohugo.io/installation/)。
我是使用ubuntu系統，這邊預設已經安裝git，安裝語法如下。
```bash
# 先安裝sass套件
sudo snap install dart-sass
# 安裝hugo
sudo snap install hugo
```
安裝完成後可以執行檢查版本
```bash
hugo --version
```
### 嘗試建立第一個專案
```bash
# 建立專案
hugo new site quickstart
cd quickstart
git init
# 加入theme ananke 作為git的submodule，方便與原專案分離更新
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
# 對當前專案指定使用ananke作為theme
echo "theme = 'ananke'" >> hugo.toml
# 執行web server顯示成果
hugo server
```
### 加入內容
執行上述步驟後應該已經能夠看到一個首頁黑白的簡單homepage了。
接著我們要加入個人的內容，我們可以使用hugo內建的指令
```bash
# 建立一個叫做my-first-post的post
hugo new content posts/my-first-post.md
```
此時我們再去`content/posts/`下就會看到出現了一個md檔案
```markdown
+++
title = 'My First Post'
date = 2023-10-20T21:37:17+08:00
draft = true
+++
```
與空白專案的內容不同，他的開頭會有這樣的文字。須注意這是hugo的markdown必要的metadata，如果刪除了就不會出現在首頁上了。
我們接著加上幾行自己的內容。參照 [markdown語法教學](https://markdown.tw/)
```markdown
+++
title = 'My First Post'
date = 2023-10-20T21:37:17+08:00
draft = false
+++

# hello world
hello
```
這邊須注意要將draft改回false，否則`hugo server`會不顯示，相對的需要使用`hugo server -D`的模式才會顯示草稿內容。

### 發布
只要執行指令`hugo`就能開始根據內容進行打包建置。結果會在`public`資料夾中。如果你剛好也有python3，我們可以執行內建的http server做簡單測試。
```bash
cd public
python3 -m http.server
```
預設會在port 8000上，我們打開瀏覽器`localhost:8000`就能看到本次建置的靜態網站了。

## 問題

### 我要如何客製化模板?
一般來說模板都有自己的document可以提供客製化需求。如這個blog使用的是 [stack](https://github.com/CaiJimmy/hugo-theme-stack) 。我在這個模板中遇到的問題就是要加入不存在theme當中的幾個icon。所以我要做的步驟會是前往原 repository fork 一份到自己的repository下，再進行客製化加入icon。

### 找到了喜歡的模板不知道怎麼開始?
通常模板專案下有基礎的 example site 可以參考他使怎麼使用這個模板的。以 [stack](https://github.com/CaiJimmy/hugo-theme-stack) 為例，他存在`exampleSite`這個資料夾，裡面涵蓋了content與config.yaml等，可以直接將他複製出來到專案目錄中檢視。