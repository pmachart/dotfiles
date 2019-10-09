#!/usr/bin/env bash
#
#  DunstX : sound and brightness control for the Dunst notification daemon
#
#  Project home : https://github.com/pmachart/dotfiles
#  Released under MIT licence
#
###
#
#  Usage :
#   ./dunstx.sh <up|down|mute|mic|brighter|darker>
#   Can be run with a system-wide keybinding. i3wm example :
#   bindsym XF86AudioRaiseVolume exec --no-startup-id ~/.config/dunst/dunstx.sh up

function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get ${1} | grep '\[off\]' > /dev/null
}

function get_brightness {
  xbacklight | LC_ALL=C xargs /usr/bin/printf "%.*f" 0 ${p}
}

function sound_notification {
  local ICON="${ICONPATH}/status/audio-volume-medium.png"
  local -r TIMEOUT='800'
  local URGENCY='normal'
  local -r VOLUME=$(get_volume)
  local VOLMSG=" [$(get_volume)%]"
  local STATUS=''

  if [[ ${1} == 'Microphone' ]] ; then
    VOLMSG=''
    ICON="${ICONPATH}/status/microphone-sensitivity-high.png"
    $(is_mute Capture)  && URGENCY='critical' && ICON="${ICONPATH}/status/microphone-sensitivity-muted.png"
  else
    [[ ${VOLUME} -ge 70 ]] && ICON="${ICONPATH}/status/audio-volume-high.png"
    [[ ${VOLUME} -le 30 ]] && ICON="${ICONPATH}/status/audio-volume-low.png"
    $(is_mute Master) && [[ ${1} == 'Volume' ]] && STATUS=' (Mute)'
    $(is_mute Master) || [[ ${VOLUME} == 0 && ${1} == 'Volume' ]] && URGENCY='critical' && ICON="${ICONPATH}/status/audio-volume-muted.png"
  fi

  eval ${NOTIFIER} -i ${ICON} -r 98765 -t ${TIMEOUT} -u ${URGENCY} "\"${@}${VOLMSG}${STATUS}\""
  # eval avoids the text getting split between summary and body. insights welcome !
}

function brightness_notification {
  local -r ICON="${ICONPATH}status/display-brightness.png"
  local -r TIMEOUT='800'
  local URGENCY='low'
  local -r BRIGHTNESS=$(get_brightness)
  [[ ${BRIGHTNESS} -le 5 ]] && URGENCY='critical'
  [[ ${BRIGHTNESS} -ge 100 ]] && URGENCY='normal'

  eval ${NOTIFIER} -i ${ICON} -r 98765 -t ${TIMEOUT} -u ${URGENCY} "\"Brightness : ${BRIGHTNESS}%\""
}

function radio_notification {
  local ICON="${ICONPATH}status/network-wireless-signal-excellent.png"
  local -r TIMEOUT='1000'
  local URGENCY='normal'
  local ACTION=${!#}
  [[ ${ACTION} == 'OFF' ]] && URGENCY='critical' && ICON="${ICONPATH}status/network-wireless-offline.png"

  eval ${NOTIFIER} -i ${ICON} -r 98765 -t ${TIMEOUT} -u ${URGENCY} "\"${@}\""
}


function dunstx {
  local -r ICONPATH='/usr/share/icons/HighContrast/48x48/'
  local -r NOTIFIER='~/.local/bin/dunstify'
  local MSG='on'

  case ${1} in
    up)
      /usr/bin/amixer -q set Master 5%+
      sound_notification Volume up
      ;;
    down)
      /usr/bin/amixer -q set Master 5%-
      sound_notification Volume down
      ;;
    mute)
      /usr/bin/amixer -q set Master toggle
      $(is_mute Master) && MSG='off'
      sound_notification Sound ${MSG}
      ;;
    mic)
      /usr/bin/amixer -q set Capture toggle
      $(is_mute Capture) && MSG='off'
      sound_notification Microphone ${MSG}
      ;;

    brighter)
      /usr/bin/xbacklight -inc ${2}
      brightness_notification
      ;;
    darker)
      /usr/bin/xbacklight -dec ${2}
      brightness_notification
      ;;
    brightest)
      /usr/bin/xbacklight -set 100
      brightness_notification
      ;;
    darkest)
      /usr/bin/xbacklight -set 5
      brightness_notification
      ;;

    allon)
      /usr/sbin/rfkill unblock bluetooth
      /usr/bin/nmcli radio wifi on && radio_notification All networks ON
      ;;
    alloff)
      /usr/sbin/rfkill block bluetooth
      /usr/bin/nmcli radio all off && radio_notification All networks OFF
      ;;
    wifion)
      /usr/bin/nmcli radio wifi on && radio_notification Wifi ON
      ;;
    wifioff)
      /usr/bin/nmcli radio wifi off && radio_notification Wifi OFF
      ;;
    bton)
      /usr/sbin/rfkill unblock bluetooth
      radio_notification Bluetooth ON
      ;;
    btoff)
      /usr/sbin/rfkill block bluetooth
      radio_notification Bluetooth OFF
      ;;
  esac

}

dunstx ${@}
