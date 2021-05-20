#!/bin/bash
#Variables declarations
snort_interface="enp0s3"
#home_net=`hostname -I | awk '{print $1}'`
home_net="172.20.16.206/32"

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
cd ..

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
sudo ldconfig

echo "####SNORT 3.O CONFIGURE THE SERVICE"

#Configure netword interface
sudo ip link set dev ${snort_interface} promisc on
sudo ip add sh ${snort_interface}

#Disable Interface
ethtool -k ${snort_interface} | grep receive-offload
sudo ethtool -K ${snort_interface} gro off lro off

#Create and enable a systemd service unit
sudo bash -c "cat << END > /etc/systemd/system/snort3-nic.service
[Unit]
Description=Set Snort 3 NIC in promiscuous mode and Disable GRO, LRO on boot
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ip link set dev ${snort_interface} promisc on
ExecStart=/usr/sbin/ethtool -K ${snort_interface} gro off lro off
TimeoutStartSec=0
RemainAfterExit=yes

[Install]
WantedBy=default.target
END"

#Reload systemd configuration settings
sudo systemctl daemon-reload

#Start and enable the serice
sudo systemctl enable --now snort3-nic.service

#Create the snort3 rules folder
sudo mkdir /usr/local/etc/rules

#Download Snort 3 community rules & extract them
wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz
sudo tar xzf snort3-community-rules.tar.gz -C /usr/local/etc/rules/
#ls /usr/local/etc/rules/snort3-community-rules/

#Configure /usr/local/snort/snort.lua
sed -i 's/HOME_NET = 'any'/HOME_NET = '$home_net'/g' /usr/local/snort/snort.lua

#DEFAULTS
/usr/local/etc/snort/snort_defaults.lua include = 'snort3-community.rules' en la parte de ips

echo "####SNORT 3.O INSTALLING OPENAPPID"

#Download the pakages
wget https://snort.org/downloads/openappid/17843 -O OpenAppId-17843.tgz
tar -xzvf OpenAppId-17843.tgz
sudo cp -R odp /usr/local/lib/

#Copy and configure the location of the OpenAppID
sudo cp /usr/local/etc/snort/snort.lua /usr/local/etc/snort/snort.lua.back
sudo bash -c 'cat << END >> /usr/local/etc/snort/snort.lua
appid =
{
    -- appid requires this to use appids in rules
    --app_detector_dir = 'directory to load appid detectors from'
    app_detector_dir = '/usr/local/lib',
    log_stats = true,

}
END'

#Create Snort3 log directory
sudo mkdir /var/log/snort

#Check the Snort3 configuration
sudo snort -c /usr/local/etc/snort/snort.lua

#Create a rule to detect ping tests
sudo nano /usr/local/etc/rules/local.rules
alert icmp any any -> $HOME_NET any (msg:"ICMP connection test"; sid:1000001; rev:1;)

#Check the local rules
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules

sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -i enp0s3 -A alert_fast -s 65535 -k none

echo "####SNORT 3.O LOGGING"
#Configure the events loggings
sed -i 's/--alert_fast = { }/alert_fast = { 
        file = true, 
        packet = false,
        limit = 10,
}/g' /usr/local/etc/snort/snort.lua

#Check for the configuration
sudo snort -c /usr/local/etc/snort/snort.lua

#Runing the comand with the option -l /var/log/snort
sudo snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -i enp0s3 -s 65535 -k none -l /var/log/snort/
