#!/bin/bash

# Prompt for the title of the post
read -p "Enter the title of your post: " title

# Define the content directory
CONTENT_DIR="content/post"

# Create the directory for the new post
mkdir -p "$CONTENT_DIR/$title"

# Get the current date in the desired format
DATE=$(date +"%Y-%m-%dT%H:%M:%S%z")

# Create the English index file
cat <<EOL > "$CONTENT_DIR/$title/_index.en.md"
---
title: "$title"
date: $DATE
draft: false
description: ""
type: "post"
categories: []
tags: []
---
EOL

# Create the Chinese index file
cat <<EOL > "$CONTENT_DIR/$title/_index.zh.md"
---
title: "$title"
date: $DATE
draft: false
description: ""
type: "post"
categories: []
tags: []
---
EOL

# Output the result
echo "Post created at $CONTENT_DIR/$title/"
