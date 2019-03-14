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

function dobase {

	source ./base/basevar
		#sethostname
	if [ $# -eq 0 ]; then
		hostnamectl set-hostname $hostnm
	else
	 hostnamectl set-hostname $mailhostnm
  fi
	 echo "++++++++ firewalld is off ++++++++"
	 systemctl disable firewalld
	 systemctl stop firewalld
	 echo " "

echo "group_package_types=mandatory,default,optional" >> /etc/yum.conf
		yum -y group install base
		if [ $? != 0 ]; then
			echo "could not resolve DNS or no network connectivity please confirm you have internet then rerun this script "
				exit 1
		fi
		#install EPEL software repository
		echo " "
		echo "++++++ Installing EPEL +++++++"
		yum -y install epel-release

echo " "
	echo "++++++ Updating Entire System +++++++"
 	yum -y update
	sleep=2

}
