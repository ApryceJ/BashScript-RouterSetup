#!/bin/bash
#===============================================================================
#
#          FILE: selinux_seutp.sh
#
#         USAGE:this will be sourced into main.sh
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

function turnoffselnx {

	setenforce 0
	sed -r -i 's/SELINUX+(enforcing|disabled)/SELINUX+disabled/' /etc/selinux/config

}
