#!/usr/bin/env bash

echo -n "Arc:"
if [[ -n "$(/usr/bin/upower -d | grep mouse_dev_E8_1C_E1_42_49_27)" ]] ; then 
  echo -n "<span color='green'>"
  echo -n $(/usr/bin/upower -i /org/freedesktop/UPower/devices/mouse_dev_E8_1C_E1_42_49_27 | grep percentage | awk '{print $2}')
  echo "</span>"
else
  echo -n "<span color='red'>Off</font>"
fi
