#!/bin/bash


. ./witness.config

usage="${yellow}Usage: get-blockchain.sh [data-location]${normal}"

echo -e "${green}Download blockchain from gtg.steem.house for first replay. ${normal}"

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
echo -e "${cyan}Install decompression tools...${normal}"
apt-get update
apt-get install -y pixz

echo -e "${cyan}Download blockchain...${normal}"
pushd ${data_location} >/dev/null
wget https://gtg.steem.house/get/blockchain.xz/block_log.xz
#wget http://seed.steemnode.world/block_log.xz

echo -e "${cyan}Decompress blockchain...${normal}"
pixz -d block_log.xz

popd >/dev/null

echo
echo -e "${green}get-blockchain finished${normal}"
