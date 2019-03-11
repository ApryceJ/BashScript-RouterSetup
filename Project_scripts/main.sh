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


#source all scripts
source ./base/base_configuration.sh
source ./base/selinux_setup.sh
source ./network/network_setup.sh
source ./network/ospf_setup.sh
source ./unbound/unbound_setup.sh
source ./nsd/nsd_setup.sh
source ./dhcp/dhcp_setup.sh
source ./hostapd/hostapd_setup.sh
source ./postfix/postfix_setup.sh
source ./dovecot/dovecot_setup.sh
source ./iptables_basic.sh
source ./main.var

#base Config

 dobase 2>$logfile
 #turn of selinux
 turnoffselnx 2>$logfile
#network
 donetwork 2>$logfile

for opt in ${!selection[@]}
do
if [ ${selection[$opt]} == true ]
then
  echo "++++++++ Turning On $opt ++++++++"
    do$opt 2>$logfile
fi
done
