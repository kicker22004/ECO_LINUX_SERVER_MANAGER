#adduser / addgroup Command
=====================
The adduser and addgroup commands are used to add a user and group to the system respectively according to the default configuration specified in /etc/adduser.conf file.
`sudo adduser eco`
Begins the Add User process

#agetty Command
=====================
agetty is a program which manages physical or virtual terminals and is invoked by init. Once it detects a connection, it opens a tty port, asks for a user’s login name and calls up the /bin/login command. Agetty is a substitute of Linux getty:
`agetty -L 9600 ttyS1 vt100`

#alias Command
=====================
alias is a useful shell built-in command for creating aliases (shortcut) to a Linux command on a system. It is helpful for creating new/custom commands from existing Shell/Linux commands (including options):
`alias home=cd /home/eco/public_html`
The above command will create an alias called home for /home/eco/public_html directory, so whenever you type home in the terminal prompt, it will put you in the /home/eco/public_html directory.

#apropos Command
=====================
apropos command is used to search and display a short man page description of a command/program as follows.
`apropos adduser`

#apt Command
=====================
apt tool is a relatively new higher-level package manager for Debian/Ubuntu systems:
`sudo apt update`

#apt-get Command
=====================
apt-get is a powerful and free front-end package manager for Debian/Ubuntu systems. It is used to install new software packages, remove available software packages, upgrade existing software packages as well as upgrade entire operating system.
`sudo apt-get update`

#arch Command
=====================
arch is a simple command for displaying machine architecture or hardware name (similar to uname -m):
`arch`

#arp Command
=====================
ARP (Address Resolution Protocol) is a protocol that maps IP network addresses of a network neighbor with the hardware (MAC) addresses in an IPv4 network.
`sudo arp-scan --interface=enp2s0 --localnet `

#at Command
=====================
at command is used to schedule tasks to run in a future time. It’s an alternative to cron and anacron, however, it runs a task once at a given future time without editing any config files:

For example, to shutdown the system at 23:55 today, run:
`sudo echo "shutdown -h now" | at -m 23:55`

atq Command
atq command is used to view jobs in at command queue:
`atq`

atrm Command
atrm command is used to remove/deletes jobs (identified by their job number) from at command queue:
`atrm 2`

awk Command
Awk is a powerful programming language created for text processing and generally used as a data extraction and reporting tool.
`awk `//{print}`/etc/hosts`

batch Command
batch is also used to schedule tasks to run a future time, similar to the at command.

basename Command
basename command helps to print the name of a file stripping of directories in the absolute path:
`basename bin/findhosts.sh`

bzip2 Command
bzip2 command is used to compress or decompress file(s).

cal Command
The cal command print a calendar on the standard output.

cat Command
cat command is used to view contents of a file or concatenate files, or data provided on standard input, and display it on the standard output.

chgrp Command
chgrp command is used to change the group ownership of a file. Provide the new group name as its first argument and the name of file as the second argument like this:
`chgrp eco users.txt`

chmod Command
chmod command is used to change/update file access permissions like this.
`chmod +x sysinfo.sh`

chown Command
chown command changes/updates the user and group ownership of a file/directory like this.
`chmod -R www-data:www-data /var/www/html`

cksum Command
cksum command is used to display the CRC checksum and byte count of an input file.
`cksum README.txt`

clear Command
clear command lets you clear the terminal screen, simply type.
`clear`

cmp Command
cmp performs a byte-by-byte comparison of two files like this.
`cmp file1 file2`

comm Command
comm command is used to compare two sorted files line-by-line as shown below.
`comm file1 file2`

cp Command
cp command is used for copying files and directories from one location to another.
`cp /home/eco/file1 /home/eco/Personal/`

date
`date --set="8 JUN 2017 13:00:00"`
To learn more about how to set date in Linux, read: How to Set System Date in Linux

dir Command
dir command works like Linux ls command, it lists the contents of a directory.

echo Command
echo command prints a text of line provided to it.
`echo Test 12345`

env Command
env command lists all the current environment variables and used to set them as well.
`env`

exit Command
exit command is used to exit a shell like so.
`exit`

expr Command
expr command is used to calculate an expression as shown below.
`expr 20 + 30`

factor Command
factor command is used to show the prime factors of a number.
`factor 10`

find Command
find command lets you search for files in a directory as well as its sub-directories. It searches for files by attributes such as permissions, users, groups, file type, date, size and other possible criteria.
`find /home/eco/ -name eco.txt`

free Command
free command shows the system memory usage (free, used, swapped, cached, etc.) in the system including swap space. Use the -h option to display output in human friendly format.
`free -h`

Find Top Running Processes by Highest Memory and CPU Usage in Linux
`Smem`– Reports Memory Consumption Per-Process and Per-User Basis in Linux

grep Command
grep command searches for a specified pattern in a file (or files) and displays in output lines containing that pattern as follows.
`grep ‘eco’ domain-list.txt`

groups Command
groups command displays all the names of groups a user is a part of like this.
`groups`
`groups eco`

gzip Command
Gzip helps to compress a file, replaces it with one having a .gz extension as shown below:
`gzip passwds.txt`
`cat file1 file2 | gzip > foo.gz`

gunzip Command
gunzip expands or restores files compressed with gzip command like this.
`gunzip foo.gz`

head Command
head command is used to show first lines (10 lines by default) of the specified file or stdin to the screen:
`ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head `

history Command
history command is used to show previously used commands or to get info about command executed by a user.
`history`

hostname Command
hostname command is used to print or set system hostname in Linux.
`hostname`
`hostname NEW_HOSTNAME`

hostnamectl Command
hostnamectl command controls the system hostname under systemd. It is used to print or modify the system hostname and any related settings:
`hostnamectl`
`sudo hostnamectl set-hostname NEW_HOSTNAME`

hwclock
hwclock is a tool for managing the system hardware clock; read or set the hardware clock (RTC).
`sudo hwclock`
`sudo hwclock --set --date 8/06/2017`

hwinfo Command
hwinfo is used to probe for the hardware present in a Linux system like this.
`hwinfo`

id Command
id command shows user and group information for the current user or specified username as shown below.
`id eco`

ifconfig Command
ifconfig command is used to configure a Linux systems network interfaces. It is used to configure, view and control network interfaces.
`ifconfig`
`sudo ifconfig eth0 up`
`sudo ifconfig eth0 down`
`sudo ifconfig eth0 172.16.25.125`

kill Command
kill command is used to kill a process using its PID by sending a signal to it (default signal for kill is TERM).
`kill -p 2300`
`kill -SIGTERM -p 2300`

killall Command
killall command is used to kill a process by its name.

kmod Command
kmod command is used to manage Linux kernel modules. To list all currently loaded modules, type.

`kmod list`
last Command
last command display a listing of last logged in users.
 
ln Command
ln command is used to create a soft link between files using the -s flag like this.
`ln -s /usr/bin/lscpu cpuinfo`

locate Command
locate command is used to find a file by name. The locate utility works better and faster than it’s find counterpart.
`locate -b "\domain-list.txt"`

login Command
login command is used to create a new session with the system. You’ll be asked to provide a username and a password to login as below.
`sudo login`

ls Command
ls command is used to list contents of a directory. It works more or less like dir command.
The -l option enables long listing format like this.
`ls -l file1`

lshw Command
lshw command is a minimal tool to get detailed information on the hardware configuration of the machine, invoke it with superuser privileges to get a comprehensive information.
`sudo lshw`

lscpu Command
lscpu command displays system’s CPU architecture information (such as number of CPUs, threads, cores, sockets, and more).
`lscpu`

mkdir Command
mkdir command is used to create single or more directories, if they do not already exist (this can be overridden with the -p option).
`mkdir eco-files`
OR 
`mkdir -p eco-files`
 
more Command
more command enables you to view through relatively lengthy text files one screenful at a time.

mv Command
mv command is used to rename files or directories. It also moves a file or directory to another location in the directory structure.
`mv test.sh sysinfo.sh`

nano Command
nano is a popular small, free and friendly text editor for Linux; a clone of Pico, the default editor included in the non-free Pine package.

To open a file using nano, type:
`nano file.txt`

nc/netcat Command
nc (or netcat) is used for performing any operation relating to TCP, UDP, or UNIX-domain sockets. It can handle both IPv4 and IPv6 for opening TCP connections, sending UDP packets, listening on arbitrary TCP and UDP ports, performing port scanning.

The command below will help us see if the port 22 is open on the host 192.168.56.5.
`nc -zv 192.168.1.5 22`

netstat Command
netstat command displays useful information concerning the Linux networking subsystem (network connections, routing tables, interface statistics, masquerade connections, and multicast memberships).

This command will display all open ports on the local system:
`netstat -a | more`

nmap Command
nmap is a popular and powerful open source tool for network scanning and security auditing. It was intended to quickly scan large networks, but it also works fine against single hosts.

The command below will probe open ports on all live hosts on the specified network.
`nmap -sV 192.168.56.0/24`

nproc Command
nproc command shows the number of processing units present to the current process. It’s output may be less than the number of online processors on a system.
`nproc`

openssl Command
The openssl is a command line tool for using the different cryptography operations of OpenSSL’s crypto library from the shell. The command below will create an archive of all files in the current directory and encrypt the contents of the archive file:
`tar -czf - * | openssl enc -e -aes256 -out backup.tar.gz`

passwd Command
passwd command is used to create/update passwords for user accounts, it can also change the account or associated password validity period. Note that normal system users may only change the password of their own account, while root may modify the password for any account.
`passwd eco`

pidof Command
pidof displays the process ID of a running program/command.
`pidof init`
`pidof cinnamon`

ping Command
ping command is used to determine connectivity between hosts on a network (or the Internet):
`ping google.com`

reboot Command
reboot command may be used to halt, power-off or reboot a system as follows.
`reboot`

rename Command
rename command is used to rename many files at once. If you’ve a collection of files with “.html” extension and you want to rename all of them with “.php” extension, you can type the command below.
`rename `s/\.html/\.php/`*.html`

rm command
rm command is used to remove files or directories as shown below.
`rm file1`
`rm -rf my-files`

rmdir Command
rmdir command helps to delete/remove empty directories as follows.
`rmdir /backup/all`

shutdown Command
shutdown command schedules a time for the system to be powered down. It may be used to halt, power-off or reboot the machine like this.
`shutdown --poweroff`

wget Command
wget command is a simple utility used to download files from the Web in a non-interactive (can work in the background) way.
`wget -c http://ftp.gnu.org/gnu/wget/wget-1.5.3.tar.gz`

youtube-dl Command
youtube-dl is a lightweight command-line program to download videos and also extract MP3 tracks from YouTube.com and a few more sites.

The command below will list available formats for the video in the provided link.
`youtube-dl --list-formats https://www.youtube.com/watch?v=iR`
