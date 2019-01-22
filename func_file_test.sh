#!/bin/bash
#===============================================================================
#
#          FILE:func_file_test.sh
#
#         USAGE: sh fun_file_test.sh
#
#   DESCRIPTION: checks to see if a file exists
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

#Variable declarations
basic_file_exists(){
    declare file_name
    declare -i state_code=0

    file_name=$1

      if [ -f $file_name ]; then
        state_code=$?
        echo "The filename: $file_name exists"
        echo "The state code is: $state_code"
      else
        echo "The filename: $file_name can't be found"
        state_code=1
        echo "The state code is: $state_code"
      fi
}

if [ $# -eq 0 ]; then
  echo "No file specified : Please supply a file to search for."
  exit 1
elif [ $# -gt 1 ]; then
  echo "Sorry this script only searches for one input at a time."
  exit 1
else
  basic_file_exists $1
fi
