#!/bin/bash

. ./witness.config

usage="${yellow}Usage: print-config${normal}"

echo -e "${green}Show config. ${normal}"

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

echo -e "shm_backup_dir: ${cyan}${shm_backup_dir}${normal}"
echo -e "ssh_port: ${cyan}${ssh_port}${normal}"
echo -e "data_location: ${cyan}${data_location}${normal}"
echo -e "shared_file_size: ${cyan}${shared_file_size}${normal}"

