#!/bin/bash

# colors
. ./witness.config


usage="${yellow}Usage: build-tools.sh [data-location]${normal}"

echo -e "${green}Build steemd and cli_callet and install it to /usr/local/bin. This script is for Ubuntu 16.04.${normal}"

# running as root
if [ "$EUID" -ne 0 ]
then
	echo -e "${red}Please run this script as root${normal}"
	exit
fi
# check parameter usage
if [ $# -ne 1 ]
then
	echo -e "${usage}"
	exit
fi

# update system
echo -e "${cyan}Installing dependencies...${normal}"
apt-get update
apt-get install -y \
    autoconf \
    automake \
    cmake \
    g++ \
    git \
    libssl-dev \
    libtool \
    make \
    pkg-config \
    python3 \
    python3-jinja2
    
# Boost packages (also required)
apt-get install -y \
    libboost-chrono-dev \
    libboost-context-dev \
    libboost-coroutine-dev \
    libboost-date-time-dev \
    libboost-filesystem-dev \
    libboost-iostreams-dev \
    libboost-locale-dev \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-signals-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev
   
 # Optional packages (not required, but will make a nicer experience)
apt-get install -y \
    doxygen \
    libncurses5-dev \
    libreadline-dev \
    perl


echo -e "${cyan}Downloading steem source...${normal}"
pushd $1 >/dev/null
rm -rf steem
git clone https://github.com/steemit/steem
cd steem
git checkout stable

echo -e "${cyan}Set up build environment...${normal}"
git submodule update --init --recursive
mkdir build
cd build
cmake -DLOW_MEMORY_NODE=ON -DCMAKE_BUILD_TYPE=Release -DSKIP_BY_TX_ID=ON -DCLEAR_VOTES=ON ..

echo -e "${cyan}Make tools...${normal}"
echo -e "${cyan}(1/2) Make steemd...${normal}"
make -j$(nproc) steemd
echo -e "${cyan}(2/2) Make cli_wallet...${normal}"
make -j$(nproc) cli_wallet
echo -e "${cyan}Install tools...${normal}"
make install

popd >/dev/null

echo
echo -e "${green}Finished installing steem witness tools${normal}"
