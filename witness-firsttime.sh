#!/bin/bash


# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: witness-firsttime.sh [data-location]${normal}"

echo -e "${green)Runs steemd --replay-blockchain for first run of steemd. ${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -ne 1 ]
then
	echo -e "${usage}"
	exit
fi

echo -e "${cyan}Starting steemd...${normal}"
echo  -e "${yellow}Note: press Ctrl+C at any time to attempt clean exit${normal}"
steemd -d $1 --replay-blockchain
echo  -e "${red}steemd stopped${normal}"

echo
echo  -e "${green}witness-firsttime finished${normal}"
