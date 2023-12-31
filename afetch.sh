#!/bin/bash

# Add some color variables that point to different escape sequences
# Much easier than typing them by hand. thx siduck
c=3 b=4
for j in c b; do
  for i in {0..7}; do
    printf -v $j$i "%b" "\e[${!j}${i}m"
  done
done

# clear

# Define some variables
username=$(whoami | tr '[:upper:]' '[:lower:]')
hostname=$(uname -a | awk '{print $2}' | tr '[:upper:]' '[:lower:]')
kernel=$(uname -sr | tr '[:upper:]' '[:lower:]')
wm="$(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \" | tr '[:upper:]' '[:lower:]')"
os=$(source /etc/os-release && echo $PRETTY_NAME | tr '[:upper:]' '[:lower:]')
pkgs="$(pacman -Q | wc -l)"
shell=$(echo "$SHELL" | awk -F/ '{for ( i=1; i <= NF; i++) sub(".", substr(toupper($i),1,1) , $i); print $NF}' | tr '[:upper:]' '[:lower:]')
term=$(ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))" | tr '[:upper:]' '[:lower:]')
colors=$(for i in {0..7}; do echo -en "\e[${1}$((30 + $i))m████"; done)
mem=$(free -m | sed -n 's/^Mem:\s\+[0-9]\+\s\+\([0-9]\+\)\s.\+/\1/p')
mem_total=$(free -m | awk '/^Mem:/ {print $2}')
get_uptime() {
  IFS=. read -r s _ </proc/uptime
  d=$((s / 60 / 60 / 24))
  h=$((s / 60 / 60 % 24))
  m=$((s / 60 % 60))
  case "$d" in [!0]*) uptime="${uptime}${d}d " ;; esac
  case "$h" in [!0]*) uptime="${uptime}${h}h " ;; esac
  case "$m" in [!0]*) uptime="${uptime}${m}m " ;; esac
  echo ${uptime:-0m}
}

cat <<EOF

${c3}╭─────────────────────────╮       
${c3}│                         │             ${c3}$username${c2}@${c6}$hostname  
${c3}│                         │   ${c6}══════════════════════════════
${c3}│ ${c1}       ██  ██   ██      ${c3}│      ${c6} os     ${c7}$os
${c3}│ ${c1}     ██████████ ██      ${c3}│      ${c6} wm     ${c7}$wm
${c3}│ ${c1}       ██  ██   ██      ${c3}│      ${c6} shell  ${c7}$shell
${c3}│ ${c1}     ██████████         ${c3}│      ${c6} term   ${c7}$term
${c3}│ ${c1}       ██  ██   ██      ${c3}│      ${c6} pkgs   ${c7}$pkgs
${c3}│                         ${c3}│      ${c6} memory ${c7}$mem /${c7} $mem_total MiB
${c3}│    ${c1}Rust is the best !   ${c3}│
${c3}│                         │$colors
${c3}╰─────────────────────────╯
EOF