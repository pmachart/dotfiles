#!/usr/bin/env bash

init () {
  local WS1=${1}
  local WS2=${2}
  local WS3=${3}
  local WS4=${4}

  i3-msg workspace "${WS1}"
    exec i3-sensible-terminal &
    sleep 4

  i3-msg workspace "${WS2}"
    exec chromium &
    sleep 5

  i3-msg workspace "${WS3}"
    exec slack &
    sleep 6

  i3-msg workspace "${WS4}"
    exec code &
    sleep 4

  i3-msg workspace "${WS1}"
    dunstify 'Ready !'

  rfkill block bluetooth

  i3lock-fancy -p -g
}

init "${@}"
