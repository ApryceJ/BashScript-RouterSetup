#!/bin/bash
#===============================================================================
#
#          FILE:net_if_setup.shde
#
#         USAGE:will be sourced by network_setup.sh
#
#   DESCRIPTION: will generate eth0 eth1 and wifi adapter ifcfg-files
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

#getting alist of network devices
netdev[]=ls /sys/class/netc | grep e

#Variable delcare and load - but how to load the array??? and will it be an array of arrays???
ifcfgbunch=[]
#create a function and use network manager to create the ifcfg files from the list

define function ifcfgcreate(dev,name,ip,mask,gateway){
  #loop
  for ifcfg in ifcfgbunch
  do
  nmcli con add type ethernet con-name ifcfg.name ifname ifcfg.device ip4 ifcfg.ip/ifcfg.mask gw4 ifcfg.gateway
  done
}
