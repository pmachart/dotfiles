#! /bin/bash

function nanohistory() {
  local -r ARGS=( "${@}" )
  local ARG=''
  local FILES=''
  local FILE=''
  local -r TMP=$(mktemp)
  local -r NANOHIST="${HOME}/.nanohistory"

  uniq "${NANOHIST}" > "${TMP}"
  mv -f "${TMP}" "${NANOHIST}"

  if [[ "${#}" == 0 ]] ; then
    cat "${NANOHIST}" | nl
    exit 1
  fi

  for ARG in ${ARGS[@]} ; do
    echo arg "${ARG}"
    FILES+=" $(sed -n "${ARG}p" < "${NANOHIST}")"
  done

  # truncate excessive lines # .bak is for macos. see stackoverflow 5694228
  sed -i.bak '8,$ d' "${NANOHIST}"
  nano "${FILES}"
}

nanohistory "${@}"
