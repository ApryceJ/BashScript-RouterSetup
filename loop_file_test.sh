#!/bin/bash
#===============================================================================
#
#          FILE:loop_file_test.sh
#
#         USAGE: sh loop_file_test.sh
#
#   DESCRIPTION: checks to see if multiple files exists
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

    file_name=$@
## raises errors for nothing supplied or to many
    if [ $# -eq 0 ]; then
      echo "No file specified : Please supply a file to search for."
      exit 1
    elif [ $# -gt 5 ]; then
      echo "Sorry this script only searches for 5 files at a time."
      exit 1
    fi

    for file in $@; do
      if [ -f $file ]; then
        state_code=$?
        echo "The filename: $file exists"
        echo "The state code is: $state_code"
      else
        echo "The filename: $file can't be found"
        state_code=1
        echo "The state code is: $state_code"
      fi
    done
}
