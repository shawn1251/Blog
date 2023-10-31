---
title: "常用於filter的shell command "
date: 2023-10-30T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["devops"]
tags: ["linux", "shell", "devops"]
---

對於有在使用linux的初階使用者，cp mv ls 等的指令應該都用的很熟練了。這邊要筆記的是我一些常用但也花了一段時間才熟練的指令

## cat
大多數使用cat是用來顯示檔案的內容，如 `cat {your file}`。但其實他還有連結兩個檔案，與創建檔案寫入的功能
* 連接兩檔案
    * `cat {file1} {file2} > {merged file}`
* 創建新檔案並寫入
    * `cat > {your file}`
    * 他會接收你接下來的輸入並寫入檔案
    * 所以有些自動化腳本會使用這個指令來自動化創建檔案
        ```bash!
        cat > testFile << EOF
        {your content}
        EOF
        ```
## grep
```bash!
grep -R SELINUX /etc/*
```
* -i 忽略大小寫
* -R 包含子資料夾
* -v 反向，輸出關鍵字以外的內容

## cut
可以用來快速提取固定格式檔案中的內容。好比`/etc/passwd` 中，可以看見內容都是以":"做分隔
```
root:x:0:0:root:/root:/bin/bash
vagrant:x:1000:1000::/home/vagrant:/bin/bash
```
此時我們用cut指令
```bash!
cut -d: -f1 /etc/passwd
```
* -d 是切分的參數，後面接著":"代表要以":"做分隔
* -f1 是要提取切分後的field 1的意思，此處取出的部分會是username

出來的output就會是
```
root
vagrant
```

## awk
前一個指令`cut`適用於有適合的separator，當變化較複雜時我們使用awk。如果是上述的例子改用awk改寫會是:
```bash!
awk -F':' '{print $1}' /etc/passwd
```
* -F 是用來定義sepeartor
* {print $1} 是用來定義輸出，此處是輸出切分後的第一位

## sed
用來做文字取代，注意的是他是對stream做取代，所以不會覆蓋到原本文件。舉例如下:
```bash!
echo "this is a book." > test
# 建立一個範例文字
sed 's/book/dog/g' test
> this is a dog.
# 他將文字輸出的book替換成dog
# s 為search
# g 為global
# test 可以替換成'*'，更改複數個檔案

cat test
> this is a book.
# 原本的檔案沒有變化

# 如果要覆蓋，可以加上 -i
sed -i 's/book/dog/g' test
cat test
> this is a dog.

```

## redirection
我們在對linux下指令的輸出預設是在螢幕上，而我們也可以將輸出進行導向轉移到file。
以下有幾個重點:
* `>` 會對輸出對象覆蓋，`>>` 是append
* `1`是stdout, `2`是stderr
* 可以使用`&`對所有輸出都進行導向

```bash!
# 當目標是導出stdout，不用特別加上1
ls >> tmpfile

# lss 為不存在指令，bash會報錯，此時可以將他報錯的stderr進行導出。
lss 2>> tmpfile

# &符號代表將stdout stderr都導出
ls &>> tmpfile
lss &>> tmpfile
```

## pipe
使用pipe `|`將輸出作為下個指令的輸入。
```bash!
# 我們將ls輸出給wc計算行數
ls | wc -l

# 將free輸出的mem欄位提取出來
free | grep -i Mem
```
