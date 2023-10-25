+++
title = 'Setting GitHub page'
date = 2023-10-21T06:42:46+08:00
draft = false
+++

This article is here to document the process of building a blog using Hugo and publishing it on GitHub Pages.
GitHub provides a free personal website service called GitHub Pages. You can upload your web content to a designated format repository to make it live.

## Preparations
1. [GitHub account](https://github.com/signup)
2. [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. Your target website

## Setup
1. Click on "repository," then "New."
2. In the "repository name" field, enter "{your account name}.github.io."
3. Click "create repository."

## Upload
Next, we'll push the local website to GitHub. If you don't have a website and just want to test, you can simply create an index.html for testing.

```bash
# Initialize git for the current website
git init
# Add to the stage and commit
git add .
git commit -m "first commit"
# Create the main branch
git branch -M main
# Add the remote repository and name it origin
git remote add origin https://github.com/{your account}/{your account}.github.io.git
# Push the current project to GitHub
git push -u origin main
```
## View
If everything is fine, you can visit `https://{your account}.github.io` to see the web page you just pushed!

## Using Hugo: Building the Site and Uploading
Continuing from the previous article, ["Creating the First Post with Hugo"]({{< ref "first-post" >}}), we can use GitHub Pages to publish our results. Remember to change the baseURL in your config.

```bash
# Build
hugo
# Navigate to the static website folder
cd public
# As explained above
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/{your account}/{your account}.github.io.git
git push -u origin main
```