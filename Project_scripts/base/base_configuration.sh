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
# hostnameclt set-hostname

echo "Creating mount point, mounting, and installing VirtualBox Guest Additions"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
yum -y install kernel-devel kernel-headers dkms gcc gcc-c+
echo
sleep 3
yum -y install bzip2
sleep 2
mkdir vbox_cd
mount /dev/cdrom ./vbox_cd
./vbox_cd/VBoxLinuxAdditions.run
umount ./vbox_cd
rmdir ./vbox_cd
echo

echo "++++++++installing and updating base set of packages+++++++++++++++++++++"
echo "group_package_types=mandatory,default,optional" >> /etc/yum.conf
		yum -y group install base

		#              install EPEL software repository
		echo "++++++++ Installing EPEL++++++++++++++"
		yum -y install epel-release
		echo "++++++++ Installing DHPCD,nsd,Unbound,quagga,hostapd++++++++++++++"
		yum -y install epel-release nsd unbound dhcpd quagga hostapd
	echo "+++++++++ and Updating Entire System +++++++++++++++"
 	yum -y update
