#!/bin/bash

# go to root
cd

# server update & requesting apps install
apt-get -y  install git build-essential cmake libuv1-dev libmicrohttpd-dev software-properties-common;

# adding gcc repository
add-apt-repository -y ppa:jonathonf/gcc-7.1;

# reupdate source
apt-get -y  update;

# install cmake
apt-get -y install cmake;

# atcivate hugepages
echo 10000 > /proc/sys/vm/nr_hugepages

# creating swap files
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo /swapfile > none    swap    sw    0   0 /etc/fstab
echo vm.swappiness=10 > /etc/sysctl.conf
sysctl -p

# installing gcc
apt-get -y  install gcc-7 g++-7;

# cloning xmrigCC package
git clone https://github.com/Bendr0id/xmrigCC.git

#entering xmrigCC directory
cd xmrigCC

# build directory cmake
cmake . -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_TLS=OFF

# entering build directory make
make

# hugepages
sudo sysctl -w vm.nr_hugepages=128

# run hugpage
echo "vm.nr_hugepages = 128" >> /etc/sysctl.conf
# config
wget https://raw.githubusercontent.com/cmme7/autoxmrigCC/master/config2.json

# Go to path
cd xmrigCC

# run xmrigDaemon
./xmrigDaemon -c /home/ubuntu/xmrigCC/config2.json
