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
echo "task 1"
cat ./sampledhcp | sed '/option/!d'

# Task2 - removing empty lines
echo "task 2"
sed -r -e '/^$/d' ./sampledhcp

#task 3 - adding text to the begining of a line
  #adding: # NASP19 sed DHCP Configuration
  echo "task 3"
sed -r -e '1 i\# NASP19 sed DHCP Configuration/' ./sampledhcp

#task 4 - remove comments at the end of a line
echo "task 4"
sed -r -e 's/# (t|E[a-z]+|E[a-z]+).*$/ /' ./sampledhcp

#task 5 # changing option router values
echo "task 5"
sed -r -e 's/[^#] option  router[a-z][[:space:]]*[0-9].*/  option routers                      10.10.0.1/g' sampledhcp

#Task 6
echo "task 6"
sed -n -r -e '/range/p' ./sampledhcp | sed -r 's/[a-z]+ [0-9]+\.[0-9]+\.1\./The Ip Range is: /' | sed -r 's/[0-9]+\.[0-9]+\.1\./- /' | sed -r 's/\;/ /'

#Task 7
echo "task 7"
read -p "Pleas select a new start of DHCP Range(between 2-253): " range1
read -p "Pleas select a new end of DHCP Range(between 2-253): " range2

if [ $range1 -ge $range2 ]; then
  echo 'the end value must be bigger than the start value, and must not be the same value'
  exit 1
elif [ $range1 -gt 253 ] || [ $range2 -gt 253 ]; then
  echo "The values supplied are greater than 253"
elif [ $range1 -lt 2 ] || [ $range2 -lt 2 ]; then
  echo 'The values supplied are less than 2'
else
 sed -e "/.*range/ s/\.[0-9]*[ ;]/\.$range1 /g1" -e "/.*range/ s/\.[0-9]*[ ;]/\.$range2 /g2" ./sampledhcp
fi
