#!/bin/bash

echo 'i am enter'
set -x
# testJenkins发布到测试环境

host="webapp@192.168.1.176"
path="/opt/servplat/testJenkins"

rm -rf ./dist

cnpm install
echo "cnpm install success"

cnpm run build
echo "build success"

rsync -rcv dist/*  $host:${path}