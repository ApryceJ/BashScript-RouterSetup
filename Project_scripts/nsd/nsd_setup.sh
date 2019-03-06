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

#source files
source ./nsdvar
source ../network/network.conf
#create nsd conf file
cp ./nsd.cnf $nsdconf
cp ./frwdzone $nsdfrwzone
cp ./revzone $nsdrvzone
# Edit COnfig files
function donsd {
# edit the ip address
sed -i -E "s/ip-ad[a-z]+\: [0-9]+\.[0-9].*/ip-address: ${INTF[${devcname[0]},0]}/" $nsdconf
#sed -i -E "s/# do-[a-z]+4\:.+/do-ip/"

# edit the zone file names, need a loop can just appends

for each in ${!zonefile[@]}
do
printf "zone: \n      name: \"${each}\" \n      zonefile: \"${zonefile[$each]}\" \n" >> $nsdconf
done
#finds the last line, it should have Domain and records the line number
 linenum=$(sed -n '/domain/=' $nsdfrwzone )
#create zones files
for each in ${!frwzone[@]}
do
		#want to append again to build the zone file
		#print the NS record
		if [ $each == s09.as.learn. ]; then
			#increment the line number to insert after the last line.
			let "linenum++"
			sed -i -E "${linenum}i\$each IN  NS   ${frwzone[$each]} \n" $nsdfrwzone
		else
			#print all other records
      printf "$each IN  A   ${frwzone[$each]} \n" >> $nsdfrwzone
	fi
done

#again for the revzone file
for each in ${!rvzone[@]}
do
  #print the NS record
  if [ $each ==  9.16.10.in-addr.arpa. ]; then
		sed -i -E "${linenum}i\$each IN  NS   ${rvzone[$each]} \n" $nsdrvzone
	else
   #print all other records
	   printf "$each IN  A   ${rvzone[$each]} \n" >> $nsdrvzone
	fi
done
# start and enable service
	systemctl enable --now nsd.service
	systemctl restart nsd.service
}
#donsd
