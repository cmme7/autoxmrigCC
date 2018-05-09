
#!/bin/bash

# go to root
cd

# adding gcc repository
add-apt-repository -y ppa:jonathonf/gcc-7.1;

# reupdate source
apt-get -y  update;

# server update & requesting apps install
sudo apt-get install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev wget;

# install cmake
sudo apt-get install cmake3;

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

# Installing boost
wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.bz2

tar xvfj boost_1_67_0.tar.bz2

cd boost_1_67_0

./bootstrap.sh --with-libraries=system

./b2

# cloning xmrigCC package
git clone https://github.com/Bendr0id/xmrigCC.git

#entering xmrigCC directory
cd xmrigCC

# build directory cmake
cmake . -DBOOST_ROOT=~/boost_1_67_0

# entering build directory make
make

# hugepages
sudo sysctl -w vm.nr_hugepages=128

# run hugpage
echo "vm.nr_hugepages = 128" >> /etc/sysctl.conf
# config
wget https://raw.githubusercontent.com/cmme7/autoxmrigCC/master/config.json

# Go to path
cd xmrigCC

# run xmrigDaemon
./xmrigDaemon -c /home/ubuntu/xmrigCC/config.json


