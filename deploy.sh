#!/bin/bash

cd /sites/words

GIT_CHANGES=git pull | wc -l

if [ $GIT_CHANGES -gt 1 ]; then
    npm install
    gulp build

    NODE_ENV=production forever restart server.js
fi
