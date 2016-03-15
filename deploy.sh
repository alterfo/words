#!/bin/bash

cd /sites/words

PULL=`/usr/bin/git pull`

GIT_CHANGES=`echo $PULL | wc -l`
PACKAGE_CHANGED=`echo $PULL | grep package | wc -l `

if [ $GIT_CHANGES -gt 1 ]; then
    if [ $PACKAGE_CHANGED -eq 1 ]; then
        npm install
    fi
    gulp build

    npm run restart
fi
