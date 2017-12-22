#!/bin/bash

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
##Detect OS
DISTRO=$(lsb_release --id | awk '{print tolower($3)}')
CODENAME=$(lsb_release --codename | awk '{print $2}')
apt-get -y update
apt-get -y install screen git wget rsync unzip sysstat inotify-tools bc jq curl moreutils sudo dirmngr

##Currently hardcoded for Mono Beta (5.8) on Ubuntu and Debian.
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/$DISTRO beta-$CODENAME main" | sudo tee /etc/apt/sources.list.d/mono-official-beta.list
apt-get -y update
apt-get -y --allow-unauthenticated install mono-devel
}

do_arm() {
if [[ "$CPUINFO" == arm* ]]; then
##If arm is detected notify them that it's unsafe to run this just yet##
echo "Currently Arm isn't supported, I'll be looking into this soon."
fi
}

do_arm64() {
if [[ "$CPUINFO" == aarch64 ]]; then
##If arm is detected notify them that it's unsafe to run this just yet##
echo "Currently Arm 64-bit isn't supported, I'll be looking into this soon."
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
	mkdir $INSTALL_LOC/Backup
	mkdir $INSTALL_LOC/Files
	mkdir $INSTALL_LOC/Files/ELSM_LOGS
        mkdir $INSTALL_LOC/Server
	mkdir $INSTALL_LOC/Server/Storage
	mkdir $INSTALL_LOC/Server/Storage/Backup
	touch $INSTALL_LOC/Files/ELSM_LOGS/ELSM.log
	cp Files/* $INSTALL_LOC/Files
        echo XXX
        sleep 5
        echo XXX
        echo 40
        echo "Setting up for world distruction :)"
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
        chown -R $SUDO_USER:$SUDO_USER $INSTALL_LOC
	chmod +x /usr/bin/ELSM
	chmod +x $INSTALL_LOC/Files/watch.sh
	chmod +x $INSTALL_LOC/Files/update.sh
	chmod +x $INSTALL_LOC/Files/update.sh
	chmod +x $INSTALL_LOC/Files/upgrade
	echo XXX
        sleep 2
        echo XXX
        echo 100
        echo "Launching Main script, enjoy"
        echo XXX
        sleep 2
) | whiptail --gauge "Gathering info" 8 40 0
	whiptail --fb --msgbox "Ok everything is in order and you should now be able to run (ELSM) and start your server builds." 20 60
	clear
	echo "Ok everything is in order and you should now be able to run (ELSM) and start your server builds."
exit 0
else
        exit 0
fi

else
        do_notice
fi
