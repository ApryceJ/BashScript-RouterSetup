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


#source variables
source ./dovecotvar

function dodovecot {
#install postfix
yum -y install dovecot
#copy config file
cp ./dovecot.cnf $dovecotcnf
cp ./dove10mail.cnf $dove10mail
cp ./dove10auth.cnf $dove10auth
#loop to edit config, one array?

for each in ${!dovecnfvar[@]}
do
  linenum=$(sed -n "/my$each.+/=" $dovecotcnf)
 sed -i -E "s@my$each.+@$each = ${dovecnfvar[$each]}@" $dovecotcnf
done

#10mail config file edit
for each in ${!dovemailvar[@]}
do
  linenum=$(sed -n "/my$each.+/=" $dove10mail)
 sed -i -E "s@my$each.+@$each = ${dovemailvar[$each]}@" $dove10mail
done

#10-auth conf file edit
for each in ${!doveauthvar[@]}
do
  linenum=$(sed -n "/my$each.+/=" $dove10auth)
 sed -i -E "s@my$each.+@$each = ${doveauthvar[$each]}@" $dove10auth
done

#enable and start the service

systemctl enable --now dovecot
systemctl restart dovecot
#killall -s SIGHUP dovecot
}
dodovecot
