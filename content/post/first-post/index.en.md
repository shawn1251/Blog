---
title: "First Post with Hugo"
date: 2023-10-20T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["essay"]
---

I had a sudden inspiration to organize some of my past notes, and when looking for a platform, I took a friend's advice and chose Hugo with GitHub Pages. Here, I'll document the process.

# Hugo
Let me briefly introduce [Hugo](https://gohugo.io/). Hugo is a static website generator developed in Golang. Static websites don't rely on a backend, they're fast, and you don't need to set up a database, making them ideal for showcasing websites. In the past, many people used CMS, like WordPress, to create personal websites. However, for simpler needs, using static websites is recommended. Similar tools include [Hexo](https://hexo.io/) and [Jekyll](https://jekyllrb.com/).

Since Hugo is developed in Golang, you only need to install the pre-compiled Hugo executable when using it, without the need for other languages like Ruby or JavaScript. You can start by browsing some pre-built [Hugo template](https://themes.gohugo.io/tags/blog) to get an idea of what your future project could look like.


Here, we'll follow the official guide: https://gohugo.io/getting-started/quick-start/

## Installing Hugo
Choose the appropriate [installation method](https://gohugo.io/installation/) based on your operating system. I'm using Ubuntu, and assuming you already have Git installed, you can use the following commands:

```bash
# First, install the Sass package
sudo snap install dart-sass
# Install Hugo
sudo snap install hugo
```
After installation, you can check the version:


```bash
hugo --version
```
## Trying Your First Project
```bash
# Create a new project
hugo new site quickstart
cd quickstart
git init
# Add the 'ananke' theme as a Git submodule for easier updates
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
# Specify 'ananke' as the theme for the current project
echo "theme = 'ananke'" >> hugo.toml
# Run a web server to see the results
hugo server
```
## Adding Content
After following the above steps, you should see a simple black-and-white homepage. Now, you can add your own content using Hugo's built-in commands:

```bash 
# Create a post named 'my-first-post'
hugo new content posts/my-first-post.md
```
This will create an .md file under `content/posts/`. It will contain the following metadata, which is necessary for Hugo's markdown:

```
+++
title = 'My First Post'
date = 2023-10-20T21:37:17+08:00
draft = true
+++
```
Unlike the content in the blank markdown, this one has the above metadata which is necessary. Let's add some extra content using markdown. [markdown instruction](https://www.markdownguide.org/getting-started/)

```
+++
title = 'My First Post'
date = 2023-10-20T21:37:17+08:00
draft = false
+++

# hello world
hello
```
Be sure to change draft to `false` if you want your content to appear on the homepage. Otherwise, you need to use `hugo server -D` to display draft content.

## Publishing
Simply run the hugo command to begin building based on your content. The results will be in the `public` folder. If you also have Python 3, you can run the built-in HTTP server for a simple test:

```bash
cd public
python3 -m http.server
```
It will run on port 8000 by default. You can open your browser and go to `localhost:8000` to see the static site.

## Questions
### How can I customize the template?
Usually, template projects have documentation for customization. For example, this blog uses [stack](https://github.com/CaiJimmy/hugo-theme-stack). The issue I encountered with this template was adding a few icons that were not present in the theme. To customize it, I had to fork the original repository into my own repository and then make the necessary customizations.

### I found a template I like, but I don't know how to get started.
Typically, template projects come with a basic example site that you can refer to in order to understand how to use the template. In the case of [stack](https://github.com/CaiJimmy/hugo-theme-stack), it has an 'exampleSite' folder that contains content and config.yaml files. You can copy these files to your project directory to see how to get started.