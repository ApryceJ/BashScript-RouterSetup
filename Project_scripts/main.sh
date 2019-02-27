#!/bin/bash
#===============================================================================
#
#          FILE:main.sh 
#
#         USAGE:sh main.sh
#
#   DESCRIPTION: This script will call the other configuration scripts and dependencies. It will need a blank VM setup and configured with 2 ethenert and 1 wifi USB device.
#					Must have a basic internet configuration and a VLAN adpater configuraed and attached to eth0 or the first adapter
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com 
#  ORGANIZATION: BCIT - NASP STUDENT
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an erro

# Configure Basic setgtings, updates and turning off other services refer to sources script
	#source basic_configuration.sh, will install all packages.
	#Handle already installed

# Configure Turn Off SELINux
	#Source Selinux_Setup.sh

#Configure Newtwork
	#SED edit IfCFG files - pull from variable list??

# configure IPtables
	# run IPTables Script

#NSD_setup
	#zonefiles edited with SED?
#Unbound_setup
	#Conf files Edited with Sed?

#DHCP_setup
	#config files edited with SED?
#hostapd
	#configuration and adapter ifcfg files edited with sed?
#postfix
	#??
#dovecot
	#??