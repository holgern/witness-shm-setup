#!/bin/bash

# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: show-steemd-log.sh${normal}"

echo -e "${green) Show steemd log ${normal}"

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

echo -e "${cyan}Show log..${normal}"
journalctl -f -u steemd
