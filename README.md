# ECO LINUX SERVER MANAGER
This is an easy to use set of scripts to host an ECO server on linux.
## For new users
You only had to run this command:

`wget https://raw.githubusercontent.com/kicker22004/ECO_LINUX_SERVER_MANAGER/master/easy-install.sh; chmod +x ./easy-install.sh; ./easy-install.sh`

## For advanced users
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

Optional (For **really** advanced users), checkout to beta for lastest features.

`git checkout Beta`

And to launch do:

`./Install.sh`

This Program is now at a point where it can be used, use at your own risk....
