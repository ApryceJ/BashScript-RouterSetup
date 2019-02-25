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

#turn on packet forwarding
sysctl net.ipv4.ip_forward = 1

#turn off networkmanager and firewalld as iptables will be used.
#echo "+++++++ Turning off networkmanager +++++++"
#systemctl disable NetworkManager.service
#systemctl stop NetworkManager.service
#sleep 3
echo "+++++++ Turning off firewalld +++++++"
systemtctl disable firewalld
systemtctl stop firewalld
