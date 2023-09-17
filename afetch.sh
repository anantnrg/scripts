#!/bin/bash

clear

# Define some variables
username=$(whoami | tr '[:upper:]' '[:lower:]')
hostname=$(uname -a | awk '{print $2}' | tr '[:upper:]' '[:lower:]')
kernel=$(uname -sr | tr '[:upper:]' '[:lower:]')
wm="$(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \" | tr '[:upper:]' '[:lower:]')"
os=$(source /etc/os-release && echo $PRETTY_NAME | tr '[:upper:]' '[:lower:]')
pkgs="$(pacman -Q | wc -l)"
shell=$(echo "$SHELL" | awk -F/ '{for ( i=1; i <= NF; i++) sub(".", substr(toupper($i),1,1) , $i); print $NF}' | tr '[:upper:]' '[:lower:]')
term=$(basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//') | tr '[:upper:]' '[:lower:]')
echo $wm