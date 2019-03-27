#!/bin/bash

echo 'i am enter'
set -x
# testJenkins发布到测试环境

host="webapp@192.168.1.176"
path="/opt/servplat/testJenkins"

rm -rf ./dist

npm install
echo "npm install success"

npm run build
echo "build success"

rsync -rcv dist/*  $host:${path}