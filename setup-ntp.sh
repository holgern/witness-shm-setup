#!/bin/bash

# colors
. ./witness.config


usage="${yellow}Usage: setup-ntp.sh${normal}"

echo -e "${green}Setup ntp time correction${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo -e "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -ne 0 ]
then
	echo -e "${usage}"
	exit
fi

# update system
timedatectl set-ntp no
echo -e "${cyan}Installing dependencies...${normal}"
apt-get update
apt-get install -y \
    ntp

echo -e "${cyan}Running ntp -q..${normal}"
ntpq -np


echo
echo -e "${green}Finished installing steem witness tools${normal}"
