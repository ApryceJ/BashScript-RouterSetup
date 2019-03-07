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
	source ./basic_configuration.sh  #will install all packages.

# Configure Turn Off SELINux
	Source ./Selinux_Setup.sh

#Configure Newtwork
  source ./network/network_setup.sh

# configure IPtables
  source ./iptables_basic.sh

#NSD_setup
	#zonefiles edited with SED?
  source ./nsd/nsd_setup.sh
	donsd
#DHCP_setup
	source ./dhcp/dhcp_setup.sh
	dodhcp
#Unbound_setup
	#Conf files Edited with Sed?
	source ./unbound/Unbound_setup.sh
	dounbound
#hostapd
	#configuration and adapter ifcfg files edited with sed?
#postfix

#dovecot
