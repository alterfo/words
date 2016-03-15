#!/bin/bash

cd /sites/words
git pull
npm install
gulp build

NODE_ENV=production forever restart server.js
