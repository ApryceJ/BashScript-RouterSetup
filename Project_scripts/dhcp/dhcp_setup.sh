#!/bin/bash
#===============================================================================
#
#          FILE dhcp_setup.sh:
#
#         USAGE:will be invoked by main.sh
#
#   DESCRIPTION: will setup and configure dhcp scopes and start service
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

source ./dhcp.conf
#source ../network/network.conf
#delete config file
function dodhcp {
#generate new one
  cp ./dhcp.cnf $dhcpcf

#global options
  sed -i -E "s/(opt[a-z]+ dom[a-z]+-[a-z]+ \"[a-zA-Z].+)/option domain-name \"$dname\";/" $dhcpcf
  sed -i -E "s/(opt[a-z]+ dom[a-z]+-[a-z]+-[a-z].+)/option domain-name-servers 10.16.9.126;/" $dhcpcf

#get length of array and divide by 2 - this is poor
lendhcp=$((${#dhcpset[@]} / 2))
net=0
#eth1 or student lan subnet loop for each interface
for dhc in ${dhcpname[@]}
do
	 printf "\n subnet ${netval[$net]} netmask ${dhcpset[$dhc,0]} { \n" >> $dhcpcf
    for ((i=0; i<$lendhcp; i++))
    do
       if [ "$i" -eq 1 ]; then
         rangestart=$i
      elif [ "$i" -eq 2 ]; then
      printf "%s  range ${dhcpset[$dhc,$rangestart]} ${dhcpset[$dhc,$i]}; \n" >> $dhcpcf
    elif [ "$i" -eq 3 ]; then
	    printf "%s  option routers ${dhcpset[$dhc,$i]}; \n" >> $dhcpcf
    elif [ "$i" -eq 4 ]; then
	    printf "%s  option broadcast-address ${dhcpset[$dhc,$i]};  \n } \n " >> $dhcpcf
    fi
  done
  let "net++"
done

#static assignmennt loop
for each in ${!static[@]}; do
  mac=$(echo ${static[$each]} | cut -d',' -f1)
  ip=$(echo ${static[$each]} | cut -d',' -f2)
  printf "\n host $each \n   hardware ethernet $mac; \n   fixed-address $ip; \n } \n " >> $dhcpcf
done
#start services
   systemctl enable --now dhcpd
 }

#dodhcp