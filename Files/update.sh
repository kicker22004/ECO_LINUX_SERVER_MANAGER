#!/bin/bash

#Add color for info.
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
CLEAR="tput sgr0"

case "$1" in
   (*)
    SELECTED_DIR=$2
    ;;
esac

##Killing this until I can fix bugs.
exit 1
## This should stop the crash moving to ELSM 2.0
if [ -z $SELECTED_DIR ]; then
mkdir /opt/ELSM/ELSM2_Backup
screen -X -S WATCH quit
screen -X -S ECO quit
sleep 5
cp -a /opt/ELSM/Server/. /opt/ELSM/ELSM2_Backup/
cp /opt/ELSM/Files/conf.cfg /opt/ELSM/ELSM2_Backup/
cd /opt/ELSM/
git clone https://github.com/kicker22004/ECO_LINUX_SERVER_MANAGER.git
rm -rf /opt/ELSM/Files/*
rm -rf /opt/ELSM/Server/*
cd ECO_LINUX_SERVER_MANAGER
sudo mv ELSM /usr/bin/ELSM
cp Files/* /opt/ELSM/Files/
mkdir /opt/ELSM/Server/ECO
cp -a /opt/ELSM/ELSM2_Backup/. /opt/ELSM/Server/ECO/
cp /opt/ELSM/Files/conf.cfg /opt/ELSM/Server/ECO/conf.cfg
cat <<EOF >> changelog
1. Your server was killed, I would NEVER do this if I could avoid it!.
2. Multi-Server support! (make sure to select your ports correctly).
3. I know this seems like a small changelog, But trust me it's a lot of time and work.
EOF
whiptail --fb --title "ELSM Changelog 0.1.5" --textbox changelog 20 60
rm changelog
source /opt/ELSM/ELSM2_Backup/conf.cfg
sed -i "s/ECO_VERSION=.*/ECO_VERSION=$ECO_VERSION/g" /opt/ELSM/Server/ECO/conf.cfg
sed -i "s/check=.*/check=$check/g" /opt/ELSM/Server/ECO/conf.cfg
sed -i "s/startonboot=.*/startonboot=$startonboot/g" /opt/ELSM/Server/ECO/conf.cfg
rm -rf /opt/ELSM/ECO_LINUX_SERVER_MANAGER
rm -rf /opt/ELSM/ELSM2_Backup
exit 1
fi


do_run() {
DIR="/opt/ELSM/Server"
source $DIR/$SELECTED_DIR/conf.cfg
echo $DIR/$SELECTED_DIR
        cd $INSTALL_LOC
        wget -q https://raw.githubusercontent.com/kicker22004/ECO_Linux_Server_Manager/master/Files/conf.cfg -O conf.cfg
        source conf.cfg
        echo $SELECTED_DIR
        find=$(grep "ELSM_VERSION" conf.cfg > tmp)
        find=$(cat tmp | cut -d "=" -f2)
        clear
        echo -e ${yellow}"Version found online: $find"
        unset BSCC_VERSION
        source $DIR/$SELECTED_DIR/conf.cfg
        echo "Currently Installed Version: $ELSM_VERSION"
	echo -e ${green}"Created and Maintained by: Kicker22004"
        $CLEAR
if [ $find = $ELSM_VERSION ]; then
        echo -e ${green}"You are up to date."
        echo "Launching Program!"
        $CLEAR
        sleep 1
        rm conf.*
        rm tmp
        exit 0
        /usr/bin/ELSM
else
        rm conf.*
        rm tmp
        clear
        echo -e ${red}"An Updated Version was found, Grabbing files"
        $CLEAR
        sleep 2
        cd /opt/ELSM/Files/
        wget -q https://raw.githubusercontent.com/kicker22004/ECO_LINUX_SERVER_MANAGER/master/Files/upgrade -O upgrade
        chmod +x upgrade
        /opt/ELSM/Files/upgrade "${SELECTED_DIR[@]}"
        echo -e ${green}"You are up to date."
        echo "Launching Program!"
        $CLEAR
        sleep 2
        exit 0
        source $DIR/$SELETED_DIR/conf.cfg
        exit 1
        /usr/bin/ELSM
fi
}
do_run
