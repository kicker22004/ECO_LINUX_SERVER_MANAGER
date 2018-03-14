# ECO_LINUX_SERVER_MANAGER
This is an easy to use set of scripts to host an ECO server on linux.


DON'T INSTALL THIS RIGHT NOW (3/14/18). IT'S CURRENTLY BROKEN AND WILL CAUSE MORE ISSUES THEN NEEDED. PLEASE STAND BY.


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
