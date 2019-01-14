#!/bin/bash - 
#===============================================================================
#
#          FILE: is_package_installed.sh
# 
#         USAGE: ./package_installed.sh packagename
# 
#   DESCRIPTION: determines if a user specified package has been installed
#                Echo's "status" to standard output 
#                Returns exit code of 0 if it is.
# 
#       OPTIONS: ---
#  REQUIREMENTS: yum command must be available
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Thomas Lane (tl), tlane@bcit.ca
#  ORGANIZATION: BCIT
#       CREATED: 04/22/2015 18:56
#      REVISION: 1.0
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#Variable Declarations
# See man declare (part of bash builtins)
# Deprecated Alternatives to the declare command: typeset, local
# Switches 
#   -a     indexed array 
#   -A     associative array 
#   -f     function 
#   -i     integer, arithmetic evaluation is performed when the variable is assigned a value.
#   -l     all upper-case characters are converted to lower-case.
#   -r     readonly, cannot be assigned values by assignment statements 
#   -u     all lower-case characters are converted to upper-case
#   -x     Mark names for export to subsequent commands via the environment.

declare -r SCRIPTVERSION="1.0"
declare package_name  
declare yum_output
declare -i package_installed=1

#Get the desired package from the user using the read bash builtin
# see read man page, here the -p means prompt
# http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_08_02.html
#Also note the line continuation character at the end of the line to allow for 
#proper formating
read -p "Please enter the name of the package you would like to see if is installed: " \
  package_name

#Use yum to determine if the named package is installed
#Silence errors by redirecting standard standard error to /dev/null
#Capture standard output and store in variable
yum_output=$( yum list installed $package_name 2> /dev/null )

#Store the command exit status
# See Bash Reference 3.4 Shell Parameters (3.4.2 Special Parameters) Specifically
package_installed=$?


echo "The output from the yum list installed command is: $yum_output"

if [[ $package_installed == 0 ]] ; then
  echo "$package_name is installed" 
else
  echo "$package_name isn't installed"
fi

echo "Exit code of this function is: $package_installed"

exit $package_installed


