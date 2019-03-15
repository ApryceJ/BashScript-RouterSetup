#!/bin/bash
#===============================================================================
#
#          FILE:hostapd_setup.sh
#
#         USAGE:will be invoked by the main.sh
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


function dohostapd {
  yum -y install hostapd

source ./hostapd/hostapdvar

#set conf variables
cp ./hostapd/hostapd.cnf $hostcnf
#looop to edit configuration
for each in ${!hostap[@]}
do
 sed -i -E " s@my$each.+@$each=${hostap[$each]}@" $hostcnf
done

lencustwifi=${#custwifi[@]}
for ((i=0; i<$lencustwifi; i++))
do
 printf "${custwifi[$i]}\n" >>  $hostcnf
done

#start services
systemctl enable --now hostapd
sleep 3
systemctl restart dhcpd #restarting dhcpd again for a 3 time
}
