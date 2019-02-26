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

#https://fedoraproject.org/wiki/Networking/CLI
#nmcli con mod $dev ipv4.dns “8.8.8.8 8.8.4.4”
function concreate {
 source ./network.conf
  netdev=$(ls /sys/class/net | grep e)
#load the address variables
    $ip=${INTF[netdev[0],0]}
    $pFIX=${INTF[netdev[0],1]}
    $GW=${INTF[netdev[0],2]}
    #$DNS

#connection creation
  for dev in $(netdev)
  do
    #delete existing connections
    nmcli con delete id $dev
    #create connections
    nmcli con add type ethernet con-name $dev ifname $dev ip4 $ip/$pFIX gw4 $GW
  done
}

concreate
