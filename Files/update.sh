#!/bin/bash

#Add color for info.
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
CLEAR="tput sgr0"

case "$1" in
   (*)
    SELECTED_DIR=$1
    ;;
esac

do_run() {
DIR="/opt/ELSM/Server"
source $DIR/$SELECTED_DIR/conf.cfg
LOCK=$SELECTED_DIR
    cd $INSTALL_LOC
    wget -q https://raw.githubusercontent.com/$GIT_REPO_USER/ECO_LINUX_SERVER_MANAGER/$DEFAULT_BRANCH/Files/conf.cfg -O conf.cfg
    source conf.cfg
    find=$(grep "ELSM_VERSION" conf.cfg > tmp)
    find=$(cat tmp | cut -d "=" -f2)
    clear
    echo -e ${yellow}"Version found online: $find"
    unset ELSM_VERSION
    source $DIR/$LOCK/conf.cfg
    echo "Currently Installed Version: $ELSM_VERSION"
    echo -e ${green}"Created and Maintained by: Kicker22004 and all the contributors <3"
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
    wget -q https://raw.githubusercontent.com/$GIT_REPO_USER/ECO_LINUX_SERVER_MANAGER/$DEFAULT_BRANCH/Files/upgrade -O upgrade
    chmod +x upgrade
    /opt/ELSM/Files/upgrade "${LOCK[@]}"
    echo -e ${green}"You are up to date."
    echo "Launching Program!"
    $CLEAR
    sleep 2
    exit 0
    source $DIR/$LOCK/conf.cfg
    exit 1
    /usr/bin/ELSM
fi
}
do_run
