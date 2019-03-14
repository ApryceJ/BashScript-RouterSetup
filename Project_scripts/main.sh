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

#display readme
#cat ./readme.md

#source all scripts
source ./main.var
source ./base/base_configuration.sh
source ./base/selinux_setup.sh
source ./network/ospf_setup.sh
source ./unbound/unbound_setup.sh
source ./network/network_setup.sh
source ./nsd/nsd_setup.sh
source ./dhcp/dhcp_setup.sh
source ./hostapd/hostapd_setup.sh
source ./postfix/postfix_setup.sh
source ./dovecot/dovecot_setup.sh
source ./network/iptables_basic.sh

if [ $runformailsrv = 0 ]; then
 for opt in ${!selection[@]} # runs for router configuration
 do
   echo " "
   echo "++++++++ ${selection[$opt]} ++++++++"
         ${selection[$opt]}
        sleep 3
  echo " "
 done
elif [ $runformailsrv = 1 ]; then
  #statements
  for opt in ${!mailselection[@]} # runs for router configuration
  do
    if [ ${mailselection[$opt]} == donetwork || ${mailselection[$opt]} == dobase ]; then
    echo " "
    echo "++++++++ ${mailselection[$opt]} ++++++++"
          ${mailselection[$opt]} $runformailsrv
         sleep 3
    echo " "
   else
    echo " "
    echo "++++++++ ${mailselection[$opt]} ++++++++"
          ${mailselection[$opt]}
      sleep 3
    echo " "
   fi
 done
fi
