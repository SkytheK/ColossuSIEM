#!/bin/bash
#Update & Upgrade our environment
sudo apt-get update
sudo apt-get upgrade -y

echo "####SNORT 3.O ENVIROMENT"

#Install all the necesary packages 
sudo apt install -y build-essential libpcap-dev libpcre3-dev libnet1-dev zlib1g-dev luajit hwloc libdnet-dev libdumbnet-dev bison flex liblzma-dev openssl libssl-dev pkg-config libhwloc-dev cmake cpputest libsqlite3-dev uuid-dev libcmocka-dev libnetfilter-queue-dev libmnl-dev autotools-dev libluajit-5.1-dev libunwind-dev

#Crate tha enviroment
mkdir snort-files
cd snort-files

#We clone the Snort3 l & enter libdaq
git clone https://github.com/snort3/libdaq.git
cd libdaq

#Configure and install libdaq
./bootstrap
./configure
sudo make
sudo make install
cd ..

#We get the gperftools for Snort3, enter on the folder and configure them
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.8/gperftools-2.8.tar.gz
tar xzf gperftools-2.8.tar.gz
cd  gperftools-2.8/
./configure
sudo make
sudo make install
cd ../

echo "####SNORT 3.O INSTALL SERVICE"

#We clone the git with Snort3 & configure them
git clone git://github.com/snortadmin/snort3.git
cd snort3/
./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc

#Build Snort3
cd build
sudo make
sudo make install

#Update shared libraries
ldconfig

echo "####SNORT 3.O CONFIGURE THE SERVICE"

#Configure netword interface
ip link set dev enp0s3 promisc on
ip add sh enp0s3

#Disable Interface
ethtool -k enp0s3 | grep receive-offload
ethtool -K enp0s3 gro off lro off


