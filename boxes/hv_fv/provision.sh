#!/bin/bash

trap 'exit 1' ERR

apt-get update
apt-get update
apt-get install -y git ant build-essential
apt-get install -y openjdk-7-jre-headless openjdk-7-jdk python3-psutil

# Required for hvmonitor:
apt-get install python3-setuptools

echo "Installation (root) complete!"

