#!/bin/bash

yellow='\e[33m'
red='\e[31m'
green='\e[0;32m'
margenta='\e[35m'
normal='\e[0m'

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

echo -e "${margenta}Securing server...${normal}"
./secure.sh
echo -e "${margenta}Running build-tools, will download, build and install steem witness tools...${normal}"
mkdir ~/git
./build-tools.sh ~/git
echo -e "${margenta}Enable zram and 4GB swap...${normal}"
./bootstrap-zram-swap.sh
echo -e "${margenta}Get compressed blockchain, decompress and add to data storage...${normal}"
./get-blockchain.sh  /usr/local/bin/witness_node_data_dir/blockchain
echo -e "${margenta}Start witness for first time in replay mode...${normal}"
echo -e "${margenta}This will take a really long time depending on your hardware!${normal}"
./witness-firsttime.sh /usr/local/bin/witness_node_data_dir/blockchain

echo
echo $MAGENTA"Finished bootstrap, your system should now be set up."$RESET
echo
echo $YELLOW"What now?!"$RESET
echo $WHITE"You need to edit the "$CYAN"config.ini"$WHITE" file in "$CYAN"~/data/"$WHITE" and"
echo "add your witness account name and WIF."$RESET
echo
echo $WHITE"Then run one of the following:"$RESET
echo $GREEN"   witness.sh          : start witness"$RESET
echo $GREEN"   witness-ramdisk.sh  : start witness on RAM disk"$RESET