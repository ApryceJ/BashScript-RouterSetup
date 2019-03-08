#!/bin/bash
#===============================================================================
#
#          FILE:hostapd_setup.sh
#
#         USAGE:will be invoked by the main.sh
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

#source FILE
source ./hostapdvar
function do hostapd {

#set conf variables

#looop to edit configuration

#start services

systemctl enable --now hostapd

}
