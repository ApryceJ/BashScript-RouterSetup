#!/bin/bash
#===============================================================================
#
#          FILE: singal.sh
#
#         USAGE:sh singal.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com
#  ORGANIZATION: BCIT - NASP STUDENT
#    CREATED: strftime('%c')
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an erro

signal_func()
{
  #func variable declaration
  declare signaltosend
  declare pidtoaffect
  declare state_code=0

printf "Use the following to change the process:\n1 - SIGHUP \n2 - SIGINT\n15 - SIGTERM\n30 - SIGUSR1 \n "

  if [ $# -eq 0 ]; then
    echo "No Process ID or Signal specified : Please supply both."
    exit 1
  elif [ $# -gt 4 ]; then
    echo "Sorry this script only takes 4 options at a time."
    exit 1
  fi

  pidtoaffect=$1
  signaltosend=$2

case $signaltosend in
  1)
     signal="SIGHUP"
  ;;
  2)
     signal="SIGINT"
  ;;
  15)
    signal="SIGTERM"
  ;;
  30)
    signal="SIGUSR1"
  ;;
  *)
  echo "Sorry this script only signals 1-hangup,2-interupt,15-terminate,30-user"
  exit 1
  ;;
esac

kill -$signal $pidtoaffect

}

signal_func $@
