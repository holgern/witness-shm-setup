#!/bin/bash

. ./witness.config

usage="${yellow}Usage: show-steemd-log.sh${normal}"

echo -e "${green} Show steemd log ${normal}"

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

echo -e "${cyan}Show log..${normal}"
journalctl -f -u steemd
