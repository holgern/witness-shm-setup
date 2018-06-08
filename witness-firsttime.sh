#!/bin/bash


# colors
. ./witness.config

usage="${yellow}Usage: witness-firsttime.sh [data-location]${normal}"

echo -e "${green}Runs steemd --replay-blockchain for first run of steemd. ${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo -e "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -eq 1 ]
then
	data_location = $1
fi

echo -e "${cyan}Starting steemd...${normal}"
echo  -e "${yellow}Note: press Ctrl+C at any time to attempt clean exit${normal}"
steemd -d ${data_location} --replay-blockchain
echo  -e "${red}steemd stopped${normal}"

echo
echo  -e "${green}witness-firsttime finished${normal}"
