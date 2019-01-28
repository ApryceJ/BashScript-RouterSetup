#!/bin/bash
#===============================================================================
#
#          FILE: network-scripts-backup.sh
#
#         USAGE:sh script.sh input
#
#   DESCRIPTION: takes directory input and checks if exists,
#   then copies all files in that dir to a backupfolder with .bak extension.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Aaron Jones, aj : ajones125@my.bcit.ca or aaronp.jones7@gmail.com
#  ORGANIZATION: BCIT - NASP STUDENT
#      CREATED:
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an erro

dir_supplied(){
#empty input checks
    if [ $# -lt 2 ]; then
            echo "No directory copy from specified or copy too direcotry specified : Please supply a valid Directory."
      exit 1
      elif [ $# -gt 2 ]; then
        echo "This script only accepts a, copy from and a copy too, directory."
        exit 1
    fi
}
## checks if backup dir exists and then creates it if it does not
mkdir_ifnotexists(){
      if [ ! -d "$1/backup" ]; then
        echo "$1backup does not exist, creating the backup folder"
        mkdir $1backup
      fi
}

#declare dir_togoto=$("dir_supplied")
#need to ls the files in the Directory
dir_supplied $@
mkdir_ifnotexists $2
files=$(ls $1)
backupdir="$2backup"
echo "backing up the files in $1 to $backupdir"
for file in $files ;do
  #echo "backing up the files in $1 to $2backup"
  cp "$1$file" "$backupdir/$file.bak"
done
echo done
