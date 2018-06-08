#!/bin/bash

. ./witness.config

usage="${yellow}Usage: bootstrap.sh${normal}"

echo -e "${green}bootstrap.sh, ties together all scripts to download, build, install and run witness for first time${normal}"

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
./print-config.sh

echo -e "${margenta}Securing server...${normal}"
./secure.sh
echo -e "${margenta}Running build-tools, will download, build and install steem witness tools...${normal}"
mkdir ~/git
./build-tools.sh ~/git
echo -e "${margenta}Enable zram and 4GB swap...${normal}"
./bootstrap-zram-swap.sh
echo -e "${margenta}Get compressed blockchain, decompress and add to data storage...${normal}"
./get-blockchain.sh
echo -e "${margenta}Start witness for first time in replay mode...${normal}"
echo -e "${margenta}This will take a really long time depending on your hardware!${normal}"
./witness-firsttime.sh

