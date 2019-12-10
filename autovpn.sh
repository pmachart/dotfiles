#!/usr/bin/env bash

function autovpn() {
  local VPN='sy'
  local WIFI='synthesio'
  local VPNSTATUS
  local WIFISTATUS
  VPNSTATUS=$(nmcli connection show --active ${VPN} | wc -l)
  WIFISTATUS=$(nmcli connection show --active ${WIFI} | wc -l)

  if [[ "${WIFISTATUS}" -ne 0 &&  "${VPNSTATUS}" -eq 0 ]] ; then
    nmcli connection up ${VPN} > /dev/null 2>&1
  fi

}

autovpn
