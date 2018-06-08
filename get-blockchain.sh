#!/bin/bash


# colors
yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
cyan='\e[36m'
normal='\e[0m'

usage="${yellow}Usage: get-blockchain.sh [data-location]${normal}"

echo -e "${green)Download blockchain from gtg.steem.house for first replay. ${normal}"

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
echo -e "${cyan}Install decompression tools...${normal}"
apt-get update
apt-get install -y pixz

echo -e "${cyan}Download blockchain...${normal}"
pushd $1 >/dev/null
wget https://gtg.steem.house/get/blockchain.xz/block_log.xz
#wget http://seed.steemnode.world/block_log.xz

echo -e "${cyan}Decompress blockchain...${normal}"
pixz -d block_log.xz

popd >/dev/null

echo
echo -e "${green}get-blockchain finished${normal}"
