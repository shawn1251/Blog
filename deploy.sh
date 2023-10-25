#!/bin/bash
echo "Update WSL Time..."
sudo hwclock -s
echo The date is `date`
msg="Site update `date`"
echo "commit message: $msg"
hugo

cd public
git add .
git commit -m  "$msg"
git push publish master

cd ..
git add .
git commit -m  "$msg"
git push origin master
