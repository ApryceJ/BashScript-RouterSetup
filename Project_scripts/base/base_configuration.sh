#!/bin/bash
#===============================================================================
#
#          FILE:base_configuration.sh
#
#         USAGE:will be source by main.sh
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

## sethostname to s09rtr. as a variable. this will affect /etc.resolv.conf
source ./base/basevar

function dobase {
	#sethostname
	 hostnamectl set-hostname $hostnm

	 echo "++++++++ Turning off firewalld ++++++++"
	 systemctl disable firewalld
	 systemctl stop firewalld
	 echo "done"
	 echo " "

echo "group_package_types=mandatory,default,optional" >> /etc/yum.conf
		yum -y group install base
		#  install EPEL software repository
		echo "++++++ Installing EPEL +++++++"
		yum -y install epel-release
echo " "
		echo "++++++ Installing DHPCD,nsd,Unbound,quagga,hostapd ++++++"
		yum -y install nsd unbound dhcp quagga hostapd
		sleep=2
echo " "
	echo "+++++++++ Updating Entire System ++++++++++"
 	yum -y update
	sleep=2
echo " "
	echo "+++++++++ Done With Base Configuration +++++++++++++++"
}
