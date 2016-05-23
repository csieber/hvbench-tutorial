#!/usr/bin/env bash

trap 'exit' ERR

apt-get update
apt-get update
apt-get install -y git python3-psutil

git clone git://github.com/mininet/mininet
cd mininet
git checkout -b 2.2.1 2.2.1
cd ..
mininet/util/install.sh -a

