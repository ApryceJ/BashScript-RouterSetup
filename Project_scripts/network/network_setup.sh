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

function donetwork {

  #sourcing the concreate function
  source ./network/net_if_setup.sh
  source ./network/wifi_if_setup.sh
  
systemctl start NetworkManager
#turn on packet forwarding
echo " "
echo "++++++++ Turning on Packet Forwarding ++++++++"
sysctl net.ipv4.ip_forward=1
echo " "
sleep=2
echo "++++++++ Turning On the Network Taps ++++++++"
#decide if we want wifi or not - check for empty wifi var as well??
concreate
sleep=5
wificoncreate
echo " "
systemctl stop NetworkManager
systemctl restart network.service
}
