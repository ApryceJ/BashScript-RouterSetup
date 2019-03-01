#!/bin/bash
#===============================================================================
#
#          FILE:nsd_setup.sh
#
#         USAGE: wil be invoked by main.sh
#
#   DESCRIPTION: will turn on install and turn on nsd service. Edit config and zone files.
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

# Edit COnfig files

cp ./nsd.conf /etc/nsd/

#edit zones files

cp ./9.16.10.in-addr.arpa.zone /etc/nsd/
cp ./s09.as.learn.zone /etc/nsd/

# start and enable service
	systemctl enable --now nsd.service
