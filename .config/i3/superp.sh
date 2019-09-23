#!/usr/bin/env bash

function winp () {
  local -r NB_SCREENS=$(xrandr | \grep -w connected | wc -l)
  local -r PRIMARY=$(xrandr | \grep -w primary | awk '{print $1}' )
  local -r SECONDARY=$(xrandr | \grep -v primary | \grep -w connected | awk '{print $1}' )
  local -r TIMEOUT='1000'
  local -r ICONPATH='/usr/share/icons/HighContrast/48x48/'
  local ICON
  local MSG
  local URGENCY='normal'

  # this doesn't work when called from an i3 bind. wtf ?
  local -r FOCUSED=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output')

  if [[ ${1} == 'move' ]] ; then
    shift
    local TARGET=${PRIMARY}

    if [[ -n ${1} ]] ; then
      [[ ${1} == 'up' ]] && TARGET=${SECONDARY}
    else
      [[ ${FOCUSED} == ${PRIMARY} ]] && TARGET=${SECONDARY}
    fi

    i3-msg move workspace to output ${TARGET}
    return 0
  fi

  if [[ ${1} == 'refresh' ]] ; then shift
    if [[ ${NB_SCREENS} -eq 1 ]] ; then
      while read -r DEAD_SCREEN ; do
        xrandr --output ${DEAD_SCREEN} --off
      done < <(xrandr | grep -w disconnected | awk '{print $1}')
      ICON="${ICONPATH}actions/action-unavailable.png"
      MSG='No screens connected.'
      URGENCY='critical'
    else
      xrandr --output ${SECONDARY} --auto --above ${PRIMARY}
      ICON="${ICONPATH}devices/video-display.png"
      MSG='ON'
    fi
  fi

  feh --bg-fill ~/git/dotfiles/misc/debian10.png
  [[ ${1} == 'notify' ]] && dunstify -i ${ICON} -r 98765 -t ${TIMEOUT} -u ${URGENCY} "${MSG}"
}

winp "${@}"
