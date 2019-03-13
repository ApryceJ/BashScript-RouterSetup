Usage: Please run the main.sh and use the options given to deploy a Centos 7 router with wifi.

VM Setup:
centos 7 
1 wireless USB device attached to the VM
At least 2 wired or ethernet network adapters attached to the VM
an internet connection is assumed active on first run.

This script only handles 2 ehternet adpaters and 1 wireless usb adpaters for network_setup

The script will:

Install base software packages
Turn off selinux
updates entire system

In the main script var file there is a runformailsrv variable that will run options specific for the mail server. you can edit these to run a certian selection of subscripts. Eg. ospf=true to run ospf=false or anyother value to not run.


