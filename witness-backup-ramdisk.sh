#!/bin/bash

# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: witness-backup-ramdisk.sh [data-location]${normal}"

echo -e "${green)Backup content from ramdisk. ${normal}"

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

echo -e "${cyan}Backup content of ramdisk...${normal}"
echo -e "${cyan}Be sure that steemd is not running...${normal}"
cp /dev/shm/shared_memory.meta $1
cp /dev/shm/shared_memory.bin $1
echo
echo -e "${green}witness-backup-ramdisk finished${normal}"