#!/bin/bash
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#          FILE: 
#
#         USAGE:when inside the router vm ./
#
#   DESCRIPTION:will setup all network devices inside the new router 
#					
#  				install VirtualBox Guest Additions
#	     			install EPEL software repository
#		      	install base set of packages
#				   disable Network Manager, firewalld, and SELINUX
#					add the instructor user to your virtual machine

#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com 
#  ORGANIZATION: BCIT - NASP STUDENT
#      CREATED: strftime('%c') 
#      REVISION:  ---
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -o nounset                              # Treat unset variables as an erro
 
	echo "++++++++installing and updating base set of packages+++++++++++++++++++++"
		echo "group_package_types=mandatory,default,optional" >> /etc/yum.conf
		yum -y group install base
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
#              install EPEL software repository
	echo "++++++++ Installing EPEL and Updating Entire System ++++++++++++++"
		yum -y install epel-release
		yum -y update
    #              install base set of packages (dhcpd,hostapd,quagga,unbound nsd)
	  #              disable Network Manager, firewalld, and SELINUX
	  echo "Disabling selinux"
	  echo "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	  sleep 5
	  	setenforce 0
	  	sed -r -i 's/SELINUX+(enforcing|disabled)/SELINUX+disabled/' /etc/selinux/config
	  echo "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	  echo "Turning off and disabling Network Manager"
	  echo "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	  sleep 5
	  	systemctl stop NetworkManager.service
	  	systemctl disable NetworkManager.service
	  echo "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	  echo "Turning off and disabling Firewall Daemon"
	  sleep 5
	  	systemctl stop firewalld.service
	  	systemctl disable firewalld.service
	  echo 
	  #              add the instructor user to your virtual machine
	  echo "+++++++ Adding Instructor User +++++++++++++"
	  sleep 5
	  	useradd -m -G wheel,users instructor
