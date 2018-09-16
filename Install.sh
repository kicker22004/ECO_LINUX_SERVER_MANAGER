#!/bin/bash
#Global colors
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
NC='\033[0m'

## Eco Linux Server Manager Installer##
INSTALL_LOC=/opt/ELSM
CPUINFO=`lscpu | grep "Architecture" | awk '{print $2}'`
# Make sure we run with root privileges
if [ $UID != 0 ]; then
# not root, use sudo
	echo "This script needs root privileges, rerunning it now using sudo!"
	sudo "${SHELL}" "$0" $*
	exit $?
fi
# get real username
if [ $UID = 0 ] && [ ! -z "$SUDO_USER" ]; then
	USER="$SUDO_USER"
else
	USER="$(whoami)"
fi


########################################
#######  Check for Dependencies  #######
########################################
do_deps() {
##Debian mini fix (Missing lsb_release to detect version for mono)
clear
echo -e ${yellow}"Installing Dependencies...Please wait."$NC
if hash apt-get 2>/dev/null; then
  apt-get -qq install lsb-release
  ##Detect OS
  DISTRO=$(lsb_release --id | awk '{print tolower($3)}')
  CODENAME=$(lsb_release --codename | awk '{print $2}')
  apt-get -y update
  apt-get -y install screen git wget rsync unzip sysstat inotify-tools bc jq curl moreutils sudo dirmngr ca-certificates lsof nano > /dev/null
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb http://download.mono-project.com/repo/$DISTRO beta-$CODENAME main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
  apt-get -y update
  apt-get -y --allow-unauthenticated install mono-devel
  echo -e ${yellow}"Deps installed !"${NC}
else
  yum -y install screen git wget rsync unzip sysstat inotify-tools bc jq curl moreutils sudo dirmngr ca-certificates lsof nano
  rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
  su -c 'curl https://download.mono-project.com/repo/centos7-preview.repo | tee /etc/yum.repos.d/mono-centos7-preview.repo'
  yum install mono-complete
fi
}

do_arm() {
if [[ "$CPUINFO" == arm* ]]; then
##If arm is detected notify them that it's unsafe to run this just yet##
echo "Currently Arm isn't supported, I'll be looking into this soon."
exit 1
fi
}

do_arm64() {
if [[ "$CPUINFO" == aarch64 ]]; then
##If arm is detected notify them that it's unsafe to run this just yet##
echo "Currently Arm 64-bit isn't supported, I'll be looking into this soon."
exit 1
fi
}

do_x86() {
if [[ "$CPUINFO" == x86_64 ]]; then
##This will kick off the install because it's been tested and known to load (v0.6.0.2)
do_deps
fi
}

if [[ "$CPUINFO" == arm* ]]; then
do_arm
else
if [[ "$CPUINFO" == aarch64 ]]; then
do_arm64
else
if [[ "$CPUINFO" == x86_64 ]]; then
do_x86
fi
fi
fi

do_warning() {
if (whiptail --fb --title "Erase Everything??" --yesno "If you choose to do a clean install it will erase your ECO Server If you've made one already using this script.. Are you 100% sure? \
This is your only chance to back out so you have been warned!..." 20 60) then
	rm -rf $INSTALL_LOC
	rm /usr/bin/ELSM
	source Install.sh
else
	exit 0
fi
}

do_notice() {
if (whiptail --fb --title "Is Something wrong?" --yesno "You should be all setup by now. If you ran this by mistake you should leave now. \
But if your having issues you can start a clean install now." 20 60) then
	do_warning
else
	exit 0
fi
}

do_config() {
  #Add the branch in config.
  BRANCH=$(git branch | grep \* | cut -d ' ' -f2-)
  sed -i "s/DEFAULT_BRANCH=.*/DEFAULT_BRANCH=$BRANCH/" $INSTALL_LOC/Files/conf.cfg
  LAST_HASH=$(git rev-parse HEAD)
}

if [ ! -d "$INSTALL_LOC" ]; then
        if (whiptail --fb --title "ELSM Installer" --yesno "Welcome to the ECO LINUX SERVER MANAGER. \
This is the first time you have ran this so everything is going to need to be built and added to your system. \
If you agree Please, continue." 15 60) then
        (
        sleep 2
        echo XXX
        echo 20
        echo "Making Directories & Moving Files"
        mkdir $INSTALL_LOC
	mkdir $INSTALL_LOC/Archives
	mkdir $INSTALL_LOC/Backup
	mkdir $INSTALL_LOC/Files
	mkdir $INSTALL_LOC/Files/ELSM_LOGS
  	mkdir $INSTALL_LOC/Server
	touch $INSTALL_LOC/Files/ELSM_LOGS/ELSM.log
	cp Files/* $INSTALL_LOC/Files
        echo XXX
        sleep 5
        echo XXX
        echo 40
        echo "Set parameters"
        do_config
        echo "$LAST_HASH" > $INSTALL_LOC/Files/updater_data.cfg
        echo XXX
        sleep 2
        echo XXX
        echo 60
        echo "Installing Main Script"
        cp ELSM /usr/bin/
	echo XXX
        sleep 2
        echo XXX
        echo 80
        echo "Setting Permissions"
	chmod +x /usr/bin/ELSM
	chmod +x $INSTALL_LOC/Files/watch.sh
	chmod +x $INSTALL_LOC/Files/update.sh
	chmod +x $INSTALL_LOC/Files/update.sh
	chmod +x $INSTALL_LOC/Files/upgrade
	chown -R eco:eco /opt/ELSM
	echo XXX
        sleep 2
        echo XXX
        echo 100
        echo "Launching Main script, enjoy"
        echo XXX
        sleep 2
) | whiptail --gauge "Gathering info" 8 40 0
	whiptail --fb --msgbox "Everything is installed, Please run (ELSM) under the eco user. Press Ok" 20 60
	clear
	if [ ! "$SUDO_USER" = "eco" ]; then
	echo -e ${yellow}"Please logout and login as the eco user!, Then run ${green} ELSM"${NC}
	exit 0
	else
	echo -e ${yellow}"Your install has completed, Your already running on eco user so just run ${green}ELSM"${NC}
	fi
else
        exit 0
fi

else
        do_notice
fi
