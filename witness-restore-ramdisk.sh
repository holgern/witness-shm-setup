#!/bin/bash

. ./witness.config
usage="${yellow}Usage: witness-restore-ramdisk.sh ${normal}"

echo -e "${green)Restore content from ramdisk. ${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -eq 1 ]
then
    shm_backup_dir = $1
	echo -e "Backup to ${shm_backup_dir}"
fi


echo -e "${cyan}Be sure that steemd is not running...${normal}"
echo -e "${cyan}Remount /dev/shm tmpfs to (shared-file-size + 0.5 ) * 1024${normal}"
mount -o remount,size=134656M /dev/shm
echo -e "${cyan}Restore content to ramdisk...${normal}"
cp ${shm_backup_dir}/shared_memory.bin /dev/shm/
cp ${shm_backup_dir}/shared_memory.meta /dev/shm/
echo
echo -e "${cyan}witness-restore-ramdisk finished${normal}"