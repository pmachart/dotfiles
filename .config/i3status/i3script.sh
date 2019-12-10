#!/usr/bin/env bash

# shell scipt to prepend i3status with more stuff

i3status --config ~/.config/i3status/config | while :
do
  read line
  case "$(/usr/bin/xset -q | /usr/bin/grep LED | /usr/bin/awk '{print $10}')" in
    "00000000") KBD="US" ;;
    "00000001") KBD="US CAPS" ;;
    "00001000") KBD="FR" ;;
    "00001001") KBD="FR CAPS" ;;
    *) KBD="??" ;;
  esac

  VPN="OFF"
  [ -d /proc/sys/net/ipv4/conf/tun0 ] && VPN="ON"

  echo "${line}    |    VPN ${VPN}    |    ${KBD}    " || exit 1
done
