#!/bin/bash

#Add color for info.
green='\e[1;32m'
red='\e[0;31m'
yellow='\e[1;33m'
NC='\033[0m'
CLEAR="tput sgr0"

case "$1" in
   (*)
    SELECTED_DIR=$1
    ;;
esac
do_run_app() {
    echo -e ${green}"You are up to date."
    echo "Launching Program!"
    sleep 1
    exit 0
    /usr/bin/ELSM
}
do_upgrade() {
    clear
    echo -e ${red}"An Updated Version was found, Grabbing files"
    sleep 2
    cd /opt/ELSM/Files/
    wget -q https://raw.githubusercontent.com/$GIT_REPO_USER/ECO_LINUX_SERVER_MANAGER/$DEFAULT_BRANCH/Files/upgrade -O upgrade
    chmod +x upgrade
    /opt/ELSM/Files/upgrade "${LOCK[@]}"
    rm $DIR/Files/updater_data.cfg
    echo "$SERVER_SHA" > $DIR/Files/updater_data.cfg
    do_run_app
}
do_check_updates() {
    SERVER_SHA=$(curl -s https://api.github.com/repos/${GITHUB_ORGANIZATION_NAME}/${REPO_NAME}/commits/master | jq '.sha' | sed 's/"//g');
    LOCAL_SHA=$(<$DIR/Files/updater_data.cfg)
    echo -e ${yellow}"Version found online: "${green}"$SERVER_SHA"${NC}
    echo -e ${yellow}"Currently Installed Version: "${green}"$ELSM_VERSION"${NC}
    echo -e ${green}"Created and Maintained by: Kicker22004 and all the contributors <3"${NC}

    if [ $SERVER_SHA = $LOCAL_SHA ]; then
        do_run_app
    else
        do_upgrade
    fi
}
do_run() {
#Dir variables, do not touch
DIR="/opt/ELSM/Server"
source $DIR/$SELECTED_DIR/conf.cfg
LOCK=$SELECTED_DIR
cd $INSTALL_LOC
do_check_updates
}
do_run
