#!/bin/bash

. ./witness.config


usage="${yellow}Usage: bootstrap-zram-swap.sh${normal}"

echo -e "${green}Enbable zram compression for a witness node${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -ne 0 ]
then
	echo -e "${usage}"
	exit
fi

# update system
echo -e "${cyan}Installing dependencies...${normal}"
apt-get update
apt-get install -y zram-config

echo -e "${cyan}Enabling zram...${normal}"
sed -i 's|/ 2 /|/ 1 /|g' /usr/bin/init-zram-swapping
systemctl restart zram-config

echo -e "${cyan}Enabling 4GB swap...${normal}"
dd if=/dev/zero of=/swapfile bs=1M count=4096
mkswap /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee /etc/fstab

echo -e "${cyan}Set shared-file-size to 2*RAM + 4 -1 GB in config.ini...${normal}"
echo -e "${cyan}Assuming 64 GB ram now...${normal}"

echo -e "${cyan}Remount /dev/shm tmpfs to (shared-file-size + 0.5 ) * 1024${normal}"
mount -o remount,size=${shared_file_size} /dev/shm
