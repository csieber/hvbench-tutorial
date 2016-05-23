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

echo "Provision complete (root)"
