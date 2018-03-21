#!/bin/bash
#Global colors
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
NC='\033[0m'
do_branch_choice() {
    BRANCH=$(whiptail --title "Edition of ELSM" --radiolist \
"Choose your edition of ELSM" 15 60 4 \
"master" "[Stable edition of ELSM, a few bugs]" ON \
"Beta" "[For advanced users, lots of bugs !]" OFF 3>&1 1>&2 2>&3)

}
if [ $# = 1 ]; then
	GIT_REPO_USER=$1
else
	GIT_REPO_USER="kicker22004"
fi
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
#Check if user is already created
id -u eco
if [ $? = 1 ]; then
	echo -e ${yellow}"Create eco user..."${NC}
	echo -e ${yellow}"Enter eco's password"${NC}
	PASSWORD=$(mkpasswd -m sha-512)
	useradd -m -p ${PASSWORD} -s /bin/bash eco
	usermod -a -G sudo eco
	echo -e ${green}"Eco user successfully created."${NC}
else
	echo -e ${red}"Eco user already created..."
fi
#Ask for branch
do_branch_choice
#Download ELSM
echo -e ${yellow}"Downloading ELSM..."${NC}
git clone https://github.com/kicker22004/ECO_LINUX_SERVER_MANAGER.git /tmp/elsm
cd /tmp/elsm
git checkout $BRANCH
chown -R eco:eco /tmp/elsm
echo -e ${green}"ELSM successfully downloaded."${NC}

echo -e ${yellow}"Start ELSM Installer..."${NC}
chmod +xX ./Install.sh
./Install.sh
echo -e ${green}"ELSM successfully installed."${NC}
echo -e ${yellow}"Cleaning up..."${NC}
rm -rf /tmp/elsm
rm -f $DIR/easy-install.sh