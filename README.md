# ECO_LINUX_SERVER_MANAGER
This is an easy to use set of scripts to host an ECO server on linux.

STEPS TO MOVE FROM 0.1.4 - 2.0!!
 
 We will be backing up your world and them moving it all over. This seems to be the best way to handle this.
 Start by stopping your current world!
 
 `ELSM stop`
 
      * cp -a /opt/ELSM/Server/. $HOME/ELSMBACKUP
      
    Check that your server files are in the new location.
      * ls $HOME/ELSMBACKUP
      
    If all is good then continue. DO NOT IF YOUR FILES WERE NOT LISTED ON THE LAST COMMAND!!!!!
      * sudo rm -rf /opt/ELSM
    
    That is going to remove ELSM from your server. FOLLOW THE STEPS BELOW AND HAVE ELSM CREATE A NEW WORLD., Use Little_Big_planet for speed.(Same version you were running is best. Example EcoServer_v0.7.2.3
    
    AFTER YOU HAVE DONE THAT COME BACK TO THIS POINT!.
    
    Once you have created the user below and made the world go ahead and stop it again.
      * rm -rf /opt/ELSM/Server/ECO/*      (If you named your server something else with ELSM then use that name instead of ECO.
    Now move your server over to your new folder.
      
      * cp -a $HOME/ELSMBACKUP/. /opt/ELSM/Server/ECO/    (Again change ECO for your folder name if different.)
      
      * cp /opt/ELSM/Files/conf.cfg /opt/ELSM/Server/ECO/conf.cfg
      
      That should do it.

YOU NEVER WANT TO RUN THIS AS ROOT USER... IT WILL BREAK 100% OF THE TIME.

So lets make a user using root.

`adduser eco`

Give sudo permissions (Only used to make ELSM gobal)

`usermod -a -G sudo eco`

Then log into that user with the username and password you just made.

To install, run these simple commands.

`git clone https://github.com/kicker22004/ECO_LINUX_SERVER_MANAGER.git`

Change to Directory

`cd ECO_LINUX_SERVER_MANAGER`

And to launch do:

`./Install.sh`

This Program is now at a point where it can be used, use at your own risk....
