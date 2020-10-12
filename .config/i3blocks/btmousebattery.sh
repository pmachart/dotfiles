#!/usr/bin/env bash

if [[ '/usr/bin/upower -d | grep --quiet mouse_dev_E8_1C_E1_42_49_27' ]] ; then 
  echo -n "<span color='green'>Arc:"
  echo -n $(/usr/bin/upower -i /org/freedesktop/UPower/devices/mouse_dev_E8_1C_E1_42_49_27 | grep percentage | awk '{print $2}')
  echo "</span>"
fi
