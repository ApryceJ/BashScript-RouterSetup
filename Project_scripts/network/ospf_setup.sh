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

function doospf {

source ./network/networkvar

yum -y install quagga

 cp ./network/ospfd.cnf $confospfd
 cp ./network/zebra.cnf $confzebra

 #chown -r the quagga mkdir
  chown -R quagga:quagga /etc/quagga/

#edit logfiles once
 sed -i -E "s@log [a-z]+@log file $logospf@" $confospfd
 sed -i -E "s@log [a-z]+@log file $logzebra@" $confzebra

#Put hostname in zebra
sed -i -E "s/hostname/hostname $HOSTNAME/" $confzebra
#get line number log to start
 linenum=$(sed -n '/log/=' $confospfd )


for dev in ${devcname[@]}; do
 let "linenum++"
#zebra
   sed -i -E "${linenum} i\interface $dev" $confzebra
 #int description
  let "linenum++"
   sed -i -E "${linenum} i\ description $dev \n!" $confzebra
#ospf
   sed -i -E "${linenum} i\interface $dev" $confospfd
#int description
  let "linenum++"
   sed -i "${linenum} i\ description $dev \n!" $confospfd
done

  #enteres router info
 let "linenum++"
 sed -i "${linenum} i\router ospf" $confospfd
 let "linenum++"
 sed -i -E "${linenum} i\ router-id ${INTF[${devcname[0]},0]}" $confospfd

 for each in ${!ospfval[@]};
 do
   let "linenum++"
   sed -i -E "${linenum} i\ network $each\/${ospfval[$each]} area 0.0.0.0" $confospfd
 done

 #start the zebra and OSPF services
 systemctl enable --now zebra
 systemctl restart zebra.service
 systemctl enable --now ospfd
 systemctl restart ospfd.service
}
