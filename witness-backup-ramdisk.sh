#!/bin/bash

. ./witness.config

usage="${yellow}Usage: witness-backup-ramdisk.sh [data-location]${normal}"

echo -e "${green}Backup content from ramdisk. ${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo -e "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -eq 1 ]
then
    shm_backup_dir = $1
	echo -e "Backup to ${shm_backup_dir}"
	
fi

echo -e "${cyan}Backup content of ramdisk...${normal}"
echo -e "${cyan}Be sure that steemd is not running...${normal}"
cp /dev/shm/shared_memory.meta ${shm_backup_dir}
cp /dev/shm/shared_memory.bin ${shm_backup_dir}
echo
echo -e "${green}witness-backup-ramdisk finished${normal}"