#!/usr/bin/env bash

if [[ -d "/proc/sys/net/ipv4/conf/tun0" ]] ; then 
  echo -n "<span color='green'>VPN ("
  echo -n $(nmcli -t connection show --active | \grep :vpn: | awk -F ':' '{print $1}')
  echo ")</span>"
else
  echo "<span color='red'>off</span>"
fi
