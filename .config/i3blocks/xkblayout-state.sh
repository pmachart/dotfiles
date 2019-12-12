#!/usr/bin/env bash

xkblayout-state() {
  # requires markup=pango
  local CYAN="<span color='cyan'>"
  local YELLOW="<span color='yellow'>"
  local RESET="</span>"
  local KBD='??'

  case "$(xset -q | \grep LED | awk '{print $10}')" in
    "00000000") KBD="US" ;;
    "00000001") KBD="${YELLOW}CAPS${RESET} US" ;;
    "00001000") KBD="${CYAN}FR${RESET}" ;;
    "00001001") KBD="${YELLOW}CAPS${RESET} ${CYAN}FR${RESET}" ;;
    *) KBD="??" ;;
  esac

  echo ${KBD}
}

xkblayout-state
