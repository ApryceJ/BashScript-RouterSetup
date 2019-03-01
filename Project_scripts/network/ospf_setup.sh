#!/bin/bash
#===============================================================================
#
#          FILE:ospf_setup.sh
#
#         USAGE:invoked by the network_setup.sh
#
#   DESCRIPTION: will configure ospf
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

source ./network.conf
function doospf {
#clear old files and put newones in
 rm /etc/quagga/ospfd.conf
 touch /etc/quagga/ospfd.conf
 rm /etc/quagga/zebra.conf
 touch /etc/quagga/zebra.conf

#chown -r the quagga mkdir
 chown -R quagga:quagga /etc/quagga/

#configure or edit the config files

#hostname in zebra file
 echo "hostname $HOSTNAME" > $confzebra
# logfile location
  echo -e "log file $logospf\n!" > $confospfd
  echo -e "log file $logzebra\n!" > $confzebra

  for dev in ${devcname[@]}; do
  #zebra
     echo "interface $dev" >> $confzebra
   #int description
    echo -e " description $dev \n!" >> $confzebra
  #ospf
    echo "interface $dev" >> $confospfd
  #int description
    echo -e " description $dev \n!" >> $confospfd
  done

  echo "router ospf" >> $confospfd
  echo "ospf router-id ${INTF[${devcname[0]},0]}" >> $confospfd
  echo  " network ${INTF[${devcname[0]},4]}/${INTF[${devcname[0]},1]} area 0.0.0.0" >> $confospfd
  echo  " network ${INTF[${devcname[1]},2]}/${INTF[${devcname[1]},1]} area 0.0.0.0" >> $confospfd
  echo -e " network ${INTF[${devcname[2]},2]}/${INTF[${devcname[2]},1]} area 0.0.0.0\n!" >> $confospfd

    echo -e "line vty\n!" >> $confospfd
    echo -e "line vty\n!" >> $confzebra

#start the zebra and OSPF services
systemctl enable --now zebra
systemctl enable --now ospfd

}
