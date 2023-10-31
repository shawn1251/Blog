---
title: "Commonly Used Shell Commands for Filtering"
date: 2023-10-30T00:00:00+08:00
draft: false
description: ""
type: "post"
categories : ["devops"]
tags: ["linux", "shell", "devops"]
---

For Linux users who are familiar with commands like cp, mv, and ls, here are some commands I found useful but took some time to master:

## cat
Most often, cat is used to display file contents, such as `cat {your file}`. However, it can also be used to concatenate two files and create a new file.

* To concatenate two files:
    * `cat {file1} {file2} > {merged file}`
* To create a new file and write to it:
    * `cat > {your file}`
    * It will accept your input and write it to the file.
    * Some automation scripts use this command to create files, like:
        ```bash
        cat > testFile << EOF
        {your content}
        EOF
        ```
## grep
```bash
grep -R SELINUX /etc/*
```
* -i: Ignore case.
* -R: Recursively search in subdirectories.
* -v: Invert match, output lines that don't contain the keyword.

## cut
This command is useful for quickly extracting specific content from files with a fixed format, such as /etc/passwd. In this file, each line is separated by colons (":").

```
root:x:0:0:root:/root:/bin/bash
vagrant:x:1000:1000::/home/vagrant:/bin/bash
```
Using cut on this file:

```bash
cut -d: -f1 /etc/passwd
```
* -d specifies the delimiter, and we use ":" to indicate that the delimiter is a colon.
* -f1 indicates that we want to extract the first field after splitting, which is the username.

The output will be:

```
root
vagrant
```

## awk
When the separator is more complex or variable, you can use awk. For the example mentioned above, you can use awk to achieve the same result:

```bash
awk -F':' '{print $1}' /etc/passwd
```
* -F specifies the field separator.
{print $1} specifies to print the first field after splitting.

## sed
sed is used for text substitution. It operates on streams and doesn't overwrite the original file. For example:

```bash
echo "this is a book." > test
# Create a sample text
sed 's/book/dog/g' test
> this is a dog.
# It replaces "book" with "dog" in the text.
# 's' stands for search.
# 'g' stands for global.
# You can replace 'test' with '*' to change multiple files.

cat test
> this is a book.
# The original file remains unchanged.

# To overwrite, you can add -i
sed -i 's/book/dog/g' test
cat test
> this is a dog.
```

## Redirection
By default, the output of Linux commands is displayed on the screen, but you can redirect the output to a file. Here are some key points:

* `>` will overwrite the target, while `>>` appends.
* `1` is stdout, and `2` is stderr.
* You can use `&` to redirect all output.

```bash
# When the target is stdout, you don't need to specify 1.
ls >> tmpfile

# 'lss' is a non-existent command that will produce an error. You can redirect its stderr output.
lss 2>> tmpfile

# The '&' symbol redirects both stdout and stderr.
ls &>> tmpfile
lss &>> tmpfile
```

## Pipe
Use the pipe `|` to pass the output of one command as input to another.

```bash
# Count the lines by passing the output of 'ls' to 'wc'.
ls | wc -l

# Extract the 'Mem' column from the output of 'free'.
free | grep -i Mem
```