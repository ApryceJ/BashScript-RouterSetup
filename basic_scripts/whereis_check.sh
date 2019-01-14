#!/bin/bash -
#===============================================================================
#
#          FILE: whereis_check.sh
#
#         USAGE: ./whereis_check.sh
#
#   DESCRIPTION: Outputs the location of a command binary and returns an exit code
#                of zero if it is avaible or 127 if it can't be found
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Thomas Lane (tl), tlane@bcit.ca
#  ORGANIZATION: BCIT
#       CREATED: 04/23/2015 12:26
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#Variable declarations
#todo place variable declarations here

#Solicit command that should be searched and store it in the varialbe command
#todo: use read -p statement to get input from user and store it in the variable: cmd

#Store the output of the whereis invocation that searches for the users inputed
# command in the variable "whereis_output"
#todo variable assigment to output of command - follows form variable=$( command )

#Using the variable whereis_output process the output to drop the command name
#store the output in locations
locations=$( (echo $whereis_output | cut -d ":" -f 2-) )

if [[ "$locations" == "" ]]; then
  #the locations are empty i.e. command not found, tell the user
  #and set the exit code
else
  #the locations contains the path to the command tell the user
  #and set the exit code
fi
