#!/bin/bash

# secure.sh - a script to install basic security for witness node

# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: secure.sh${normal}"
ssh_port = "2020"

echo -e "${green}Script for securing a witness server${normal}"

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

# update system
echo -e "${cyan}Installing dependencies...${normal}"
apt-get update
apt-get install -y ufw

echo -e "${cyan}Enabling fail2ban...${normal}"
apt-get install fail2ban 

echo -e "${cyan}Change ssh port to ${ssh_port} for example in  /etc/ssh/sshd_config...${normal}"
echo -e "${cyan}Create a user besides root and set PermitRootLogin to off ...${normal}"
echo -e "${cyan}You can find an example sshd_config in this github ...${normal}"

echo -e "${cyan}Please do the following steps by hand, when you are sure that the server is reachable from port ${ssh_port}...${normal}"

echo -e "${margenta}ufw enable${normal}"
echo -e "${margenta}ufw allow 2020"