#!/usr/bin/env bash

trap 'exit' ERR

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get update

# Install docker
apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y docker-engine

groupadd -f docker
usermod -aG docker vagrant

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install python3 setuputils
apt-get install -y python3-setuptools

#Preparing the system for Netdata
apt-get install -y zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autogen automake pkg-config

# Install netdata- https://github.com/firehol/netdata/wiki/Installation
# Download it - the directory 'netdata' will be created
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata

# build it, install it, start it
./netdata-installer.sh

echo "Provision complete (root)"
