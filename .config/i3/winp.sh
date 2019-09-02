#!/usr/bin/env bash

function winp () {
  local -r NB_SCREENS=$(xrandr | grep -w connected | wc -l)
  local -r ID_MAIN_SCREEN=$(xrandr | grep -w primary | awk '{print $1}' )
  local -r ID_ADDI_SCREEN=$(xrandr | grep -v primary | grep -w connected | awk '{print $1}' )
  local -r TIMEOUT='1000'
  local -r ICONPATH='/usr/share/icons/HighContrast/48x48/'
  local ICON
  local MSG
  local URGENCY='normal'

  if [[ ${NB_SCREENS} -eq 1 ]] ; then

    while read -r ID_DEAD_SCREEN ; do
      xrandr --output ${ID_DEAD_SCREEN} --off
    done < <(xrandr | grep -w disconnected | awk '{print $1}')
    ICON="${ICONPATH}actions/action-unavailable.png"
    MSG='OFF'
    URGENCY='critical'

  else
    xrandr --output ${ID_ADDI_SCREEN} --auto --above ${ID_MAIN_SCREEN}
    ICON="${ICONPATH}devices/video-display.png"
    MSG='ON'
  fi
  [[ ${1} == 'notify' ]] && dunstify -i ${ICON} -r 98765 -t ${TIMEOUT} -u ${URGENCY} "Screen ${MSG}"
}

winp "${@}"
