#!/bin/bash

. ./witness.config

usage="${yellow}Usage: start-steemd-service.sh${normal}"

echo -e "${green)Starts steemd service ${normal}"

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

echo -e "${cyan}Starting service..${normal}"
systemctl start steemd.service 