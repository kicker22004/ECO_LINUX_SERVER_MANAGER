#!/bin/bash
source /opt/ELSM/Files/conf.cfg
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

do_restart() {
###Make a new logfile for the start.###
echo $(date) >> $LOG_FILE
echo "The server is down!, Attempting to restart.
Failure counter is at: $COUNTER out of 3

" >> $LOG_FILE
    cd $DIR
    $START
    let COUNTER=COUNTER+1
    sleep 5m
}

#Watch for the screen to be live every 30 seconds
COUNTER=0
while true; do
sleep 10s
   if screen -list | grep -q "ECO"; then
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
