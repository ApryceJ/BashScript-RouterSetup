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

function concreate () {

  #decide which conf file to sourced
  if [ $# -eq 0  ]; then
    source ./network/networkvar
  else
    source ./network/mailnetvar
  fi
i=0
#connection creation
  for dev in ${devcname[@]} #loops over every device in /sys/class/net
  do
    #delete existing connections
    nmcli con delete id $dev
      if [[ $i < 1 ]]; then
        #create connections gateway
       nmcli con add type ethernet con-name $dev ifname $dev ip4 ${INTF[$dev,0]}/${INTF[$dev,1]} gw4 ${INTF[$dev,2]}
       nmcli con mod $dev ipv4.dns ${INTF[$dev,3]}
      else
        nmcli con add type ethernet con-name $dev ifname $dev ip4 ${INTF[$dev,0]}/${INTF[$dev,1]}
      fi
        let "i++"
  done

}
