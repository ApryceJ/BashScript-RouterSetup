#!/bin/bash
#===============================================================================
#
#          FILE:network_setup.sh
#
#         USAGE:will be sourced by main.sh
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

function donetwork () {

  #sourcing the concreate function
  source ./network/net_if_setup.sh
  source ./network/wifi_if_setup.sh

systemctl start NetworkManager

echo "++++++++ Turning On the Network Taps ++++++++"
#decide if we want wifi or not - check for empty wifi var as well??
if [ $# -eq 0  ]; then
  echo " " #turn on packet forwarding
  echo "++++++++ Turning on Packet Forwarding ++++++++"
  sysctl -w $pktfrwd
  printf $pktfrwd >> $syscrl
  #configur wired connections
  concreate
  sleep 5
  #configure wireless adapter
  wificoncreate
  sleep 2
  systemctl stop NetworkManager
  systemctl restart network.service
else
  concreate $1
  systemctl restart network.service
fi
}
