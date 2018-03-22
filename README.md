# ECO LINUX SERVER MANAGER
This is an easy to use set of scripts to host an ECO server on linux.
## For new users
You only have to run this command:

`wget https://raw.githubusercontent.com/kicker22004/ECO_LINUX_SERVER_MANAGER/master/easy-install.sh; chmod +x ./easy-install.sh; sudo ./easy-install.sh`

## For advanced users
DO NOT RUN THIS AS ROOT USER! IT WILL BREAK 100% OF THE TIME.

To begin, lets make a new user.

`adduser eco`

Next, lets give the user sudo permissions (Only used to make ELSM gobal)

`usermod -a -G sudo eco`

Then log into that user with the username and password you just made.

To install, run these simple commands.

`git clone https://github.com/kicker22004/ECO_LINUX_SERVER_MANAGER.git`

Change to Directory

`cd ECO_LINUX_SERVER_MANAGER`

Optional (For **really** advanced users), checkout to beta for lastest features.

`git checkout Beta`

And to launch do:

`sudo ./Install.sh`

This Program is now at a point where it can be used, use at your own risk....
