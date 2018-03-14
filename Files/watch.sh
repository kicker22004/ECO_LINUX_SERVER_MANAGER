#!/bin/bash

case "$1" in
   (*)
    SELECTED_DIR=$1
    DIR="/opt/ELSM/Server"
    ;;
esac

source $DIR/$SELECTED_DIR/conf.cfg
LOG_DIR="/opt/ELSM/Files/ELSM_LOGS"
NOW=$(date "+%FT%T")

###Save last log###
if [ -f $LOG_FILE ]; then
mv $LOG_FILE $LOG_DIR/ELSM_$NOW.log
else
touch $LOG_FILE
fi

##Keep top 10 logs and remove the rest##
ls -dt $LOG_DIR/* | tail -n +11 | xargs rm -rf
###Make a new logfile for the start.###
echo "==============================================================
===This server was started on: $(date)===
==============================================================

" > $LOG_FILE

##Attempt to start ECO Before 10 second loop.
cd $DIR/$SELECTED_DIR/
$START
sleep 2
SESSIONID=$(screen -ls | awk '/\.'${SELECTED_DIR}'\t/ {print strtonum($1)}')
MONITOR="${SESSIONID}.${SELECTED_DIR}"
do_restart() {
###Make a new logfile for the start.###
echo $(date) >> $LOG_FILE
echo "The server is down!, Attempting to restart.
Failure counter is at: $COUNTER out of 3

" >> $LOG_FILE
    cd $DIR/$SELECTED_DIR
    $START
    sleep 1
    SESSIONID=$(screen -ls | awk '/\.'${SELECTED_DIR}'\t/ {print strtonum($1)}')
    MONITOR="${SESSIONID}.${SELECTED_DIR}"
    echo $SESSIONDI/$MONITOR
    let COUNTER=COUNTER+1
    sleep 1m
}

#Watch for the screen to be live every 30 seconds
COUNTER=0
while true; do
sleep 5s
   if screen -list | grep -o "${MONITOR}"; then
    COUNTER=0
else
    #We have spotted a crash of some form so let's restart the server and give it extra time.
    #Counter number is one higher so that the log will show the correct number of attempts.
if [ $COUNTER = "4" ]; then
    echo "Server was killed at: $(date)" >> $LOG_DIR/ELSM.log
    exit 1
else
    do_restart
fi
fi
done
