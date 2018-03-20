#!/bin/bash
#Global colors
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
NC='\033[0m'

#Auto install script
#Get script dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#Check for sudo
if [ $UID != 0 ]; then
# not root, use sudo
	echo ${red}"This script needs root privileges, rerunning it now using sudo!"${NC}
	sudo "${SHELL}" "$0" $*
	exit $?
fi

#Install deps
echo -e ${yellow}"Installing git..."${NC}
if hash apt-get 2>/dev/null; then
    apt-get -y install git whois > /dev/null
elif hash yun 2>/dev/null; then
    yun -y  install git whois > /dev/null
fi
echo -e ${green}"Git successfully installed."${NC}

#Create eco user
echo -e ${yellow}"Create eco user..."${NC}
echo -e ${yellow}"Enter eco's password"${NC}
PASSWORD=$(mkpasswd -m sha-512)
useradd -m -p ${PASSWORD} -s /bin/bash eco
usermod -a -G sudo eco
echo -e ${green}"Eco user successfully created."${NC}

#Download ELSM
echo -e ${yellow}"Downloading ELSM..."${NC}
git clone https://github.com/kicker22004/ECO_LINUX_SERVER_MANAGER.git /tmp/elsm
chown -R eco:eco /tmp/elsm
echo -e ${green}"ELSM successfully downloaded."${NC}

echo -e ${yellow}"Start ELSM Installer..."${NC}
cd /tmp/elsm
./Install.sh
echo -e ${green}"ELSM successfully installed."${NC}
echo -e ${yellow}"Cleaning up..."${NC}
rm -rf /tmp/elsm
rm -f $DIR/easy-install.sh