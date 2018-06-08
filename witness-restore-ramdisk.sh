#!/bin/bash

# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: witness-restore-ramdisk.sh [data-location]${normal}"

echo -e "${green)Restore content from ramdisk. ${normal}"

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


echo -e "${cyan}Be sure that steemd is not running...${normal}"
echo -e "${cyan}Remount /dev/shm tmpfs to (shared-file-size + 0.5 ) * 1024${normal}"
mount -o remount,size=134656M /dev/shm
echo -e "${cyan}Restore content to ramdisk...${normal}"
cp $1/shared_memory.bin /dev/shm/
cp $1/shared_memory.meta /dev/shm/
echo
echo -e "${cyan}witness-restore-ramdisk finished${normal}"