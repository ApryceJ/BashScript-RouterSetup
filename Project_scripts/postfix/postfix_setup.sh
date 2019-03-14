#!/bin/bash
#===============================================================================
#
#          FILE:postfix_setup.sh
#
#         USAGE:invoked by the main.sh script but run on the mail vm
#
#   DESCRIPTION: will configure and enable postfix, SASL options
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


function dopostfix {
  source ./postfix/postfixvar
  source ./postfix/certgen.sh

#generate cert
  docert $mailname
#install postfix
yum -y install postfix
#copy config file
cp ./postfix/main.cnf $postfxcnf
cp ./postfix/master.cf $postfxmstr
#loop to edit config, one array?

for each in ${!postfixvar[@]}
do
  linenum=$(sed -n "/my$each.+/=" $postfxcnf)
 sed -i -E " s@my$each.+@$each = ${postfixvar[$each]}@" $postfxcnf
done

#enable and start the service

systemctl enable --now postfix
postfix reload

}
