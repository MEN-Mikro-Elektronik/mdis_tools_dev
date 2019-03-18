#! /bin/bash

DEST=/usr/local/bin

cp git_extensions/git-log-sub $DEST

cp inspection/check_headtag.sh $DEST
cp inspection/check_license.sh $DEST
cp inspection/check_readme.sh $DEST

