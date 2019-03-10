#!/bin/bash
#===============================================================================
#
#          FILE: Unbound_setup.sh
#
#         USAGE:will be invoked by main.sh
#
#   DESCRIPTION: this script will configure the unbound service and it will listen on 2 interfaces
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



# source variables
source ./unbound/unbound.var

function dounbound {

# copy .cnf files to approperaite directories
cp ./unbound/unbound.cnf $unbndcnf

#loop for the interface
linenum=$(sed -n '/# interface:myinterface/=' $unbndcnf)
lenofint=${#interface[@]}
for ((i=0; i<lenofint; i++))
do
    let "linenum++"
    sed -i -E "${linenum}i\   interface: ${interface[$i]}" $unbndcnf
done

#loop for access-contr0l
linenum=$(sed -n '/# access-control:myaccess/=' $unbndcnf)
for each in ${!access[@]}
do
  let "linenum++"
    sed -i -E  "${linenum}i\  access-control: $each/${access[$each]} allow" $unbndcnf
    #sed -i -E  "s/access-[a-z]+\: 9/access-control: 10.16.9.0/24 allow" $unbndcnf
    #sed -i -E  "s/access-[a-z]+\: 255/access-control: 10.16.255.0/24 allow" $unbndcnf
done

#loop for localzones
linenum=$(sed -n '/# local-zone:myzones/=' $unbndcnf)
lenofzone=${#localzone[@]}
for ((i=0; i<lenofzone; i++))
do
  let "linenum++"
    sed -i -E  "${linenum}i\  local-zone: \"${localzone[$i]}\" nodefault" $unbndcnf
done

#Loop for stub zone generation
for each in ${!stubzone[@]}
do
  	 printf  "stub-zone: \n       name: \"$each\"  \n       stub-addr: ${stubzone[$each]} \n" >> $unbndcnf
done

#start/restart services
systemctl enable --now unbound
systemctl restart unbound
}
