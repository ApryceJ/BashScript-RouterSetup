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

#sourcing the concreate function
source ./net_if_setup.sh

#turn on packet forwarding
sysctl net.ipv4.ip_forward=1
#turn off firewalld as iptables will be used.
echo "+++++++ Turning off firewalld +++++++"
systemctl disable firewalld
systemctl stop firewalld
echo "done"
sleep=2
echo "++++++++ Turning On the Network Taps ++++++++"
concreate
echo "++++ Done with the network! +++++"
