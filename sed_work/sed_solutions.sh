#!/bin/bash
#===============================================================================
#
#          FILE:sed_solutions.sh
#
#         USAGE:sh sed_solutions.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com
#  ORGANIZATION: BCIT - NASP STUDENT
#      CREATED: strftime('%c')
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an erro

#Task 1 - emulating grep
cat ./sampledhcp | sed '/option/!d'

# Task2 - removing empty lines
sed -i '/^$/d' sampledhcp

#task 3 - adding text to the begining of a line
  #adding: # NASP19 sed DHCP Configuration
sed -i '1 i\# NASP19 sed DHCP Configuration/' ./sampledhcp

#task 4 - remove comments at the end of a line
sed -e '^[^#]s/#.*$//' ./sampledhcp
