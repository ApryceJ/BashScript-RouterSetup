#!/bin/bash
#===============================================================================
#
#          FILE:loop_file_exists_main.sh
#
#         USAGE:sh loop_file_exists_main.sh
#
#   DESCRIPTION: Outputs the location of a command binary and returns an exit code
#                of zero if it is avaible or 127 if it can't be found
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
set -o nounset

source ./loop_file_test.sh
basic_file_exists $@
