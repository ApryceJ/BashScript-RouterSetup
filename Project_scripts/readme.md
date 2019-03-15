Usage: Please run the main.sh and use the options given to deploy a Centos 7 router with wifi.
All service dependent values are stored in service folders in the .conf or .var files respective to the service.
.cnf files are service config files that will be copied to the target VM directories to run the service.

!!THIS SCRIPT WILL NOT RUN WITHOUT INTERNET!!

Router VM Setup:
centos 7
1 wireless USB device attached to the VM
At least 2 wired or ethernet network adapters attached to the VM
an internet connection is assumed active on first run.
This script only handles 2 ehternet adpaters and 1 wireless usb adpaters for network_setup

Mail VM Setup:
At least 1 wired or ethernet network adapters attached to the VM

The script will always run the following for both VM's:
Install base software packages
Turn off selinux and firewalld
changes the hostname respective to the runformailsrv switch stored in main.var file
updates entire system

Depending on the runformailsrv variable in the main.var file it will use different variables
for the following:
base install hostname
network
postfix
dovecot setup
