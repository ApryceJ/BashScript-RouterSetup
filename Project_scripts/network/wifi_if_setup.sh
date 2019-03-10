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

 source ./network/wifi.conf

function wificoncreate {
#connection creation
  for dev in ${wifidev[@]} #loops over every device in /sys/class/net
  do
    #delete existing connections
  nmcli con delete id $dev
  nmcli con add type wifi ssid ${wifi[$dev,2]} con-name $dev ifname $dev ip4 ${wifi[$dev,0]}/${wifi[$dev,1]}
  done
}
