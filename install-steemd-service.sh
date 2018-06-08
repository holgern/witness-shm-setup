#!/bin/bash

. ./witness.config

usage="${yellow}Usage: install-steemd-service.sh${normal}"

echo -e "${green) Install steemd service ${normal}"

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

echo -e "${cyan}Installing service..${normal}"
cp ./etc/systemd/system/steemd.service /etc/systemd/system
systemctl enable steemd.service 