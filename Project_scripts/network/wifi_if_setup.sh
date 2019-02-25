#!/bin/bash
#===============================================================================
#
#          FILE:wifi_if_setup.sh
#
#         USAGE:will be sourced by network_setup.sh
#
#   DESCRIPTION:
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

#Variable delcare and load
name=$1
dev=$2
ip=$3
mask=$4
gateway=$5
#create a function and use network manager to create the ifcfg files from the list

cd /etc/sysconfig/networkscripts

define function ifcfgcreate(dev,name,ip,mask,gateway){
  #loop
  # would i use iw here instead of nmcli???
  for ifcfg in
  do
  nmcli con add type wifi con-name $name ifname $dev ip4 $ip/$mask gw4 $gateway
  done
}
