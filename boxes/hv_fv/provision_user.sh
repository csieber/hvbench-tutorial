#!/bin/bash

trap 'exit 1' ERR

git clone https://github.com/opennetworkinglab/flowvisor.git
cd flowvisor

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
make

sudo adduser --system --disabled-login flowvisor --group

echo "Almost finished .. please execute the following command on your own now:"
echo "sudo make fvuser=flowvisor fvgroup=flowvisor install"

echo "Installation (user) complete!"

