#!/bin/bash
#===============================================================================
#
#          FILE: echo_main.sh
#
#         USAGE: bash echo_main.sh
#
#   DESCRIPTION: To call or source the cmd in echo_arguments scripts
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com
#  ORGANIZATION: BCIT - NASP STUDENT
#       CREATED:
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an error

#accepts arugment pass to echo_main
#echo $#
#echo "Begining of main.sh"
source ./echo_argument.sh
