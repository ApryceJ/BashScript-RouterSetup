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

#delete config file
function dodhcp{
#generate new one
  rm /etc/dhcpd.conf
  touch /etc/dhcpd.conf
  
#global options
  echo option domain-name $dname;

#eth1 or student lan subnet
	echo subnet 10.5.5.0 netmask ${dhcpset[${dhcpname[1]},2]} {
  	 echo range ${dhcpset[${dhcpname[1]},0]} ${dhcpset[${dhcpname[1]},1]};
	   echo option routers ${dhcpset[${dhcpname[1]},4]};
	   echo option broadcast-address ${dhcpset[${dhcpname[1]},3]};
     echo option domain-name-servers ${dhcpset[${dhcpname[1]},4]};
	   echo default-lease-time 600;
	   echo -e "max-lease-time 7200;\n }"
#wireless subnet
    echo subnet 10.254.239.0 netmask 255.255.255.224 {
    echo range 10.254.239.10 10.254.239.20;
    echo option routers rtr-239-0-1.example.org, rtr-239-0-2.example.org;
    echo -e "option domain-name-servers ; \n}"

#start services
   systemctl enable --now dhcpd
}
