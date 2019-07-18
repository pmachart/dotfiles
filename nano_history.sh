#! /bin/bash

function nanohistory() {
  local -r ARGS=( "${@}" )
  local ARG=''
  local FILES=''
  local FILE=''
  local -r TMP=$(mktemp)

  uniq ~/.nanohistory > "${TMP}"
  rm -f ~/.nanohistory
  mv "${TMP}" ~/.nanohistory

  if [[ "${#}" == 0 ]] ; then
    cat ~/.nanohistory | nl
    exit 1
  fi

  for ARG in ${ARGS[@]} ; do
    echo arg "${ARG}"
    FILES+=" $(sed -n "${ARG}p" < ~/.nanohistory)"
  done

  # truncate excessive lines # .bak is for macos. see stackoverflow 5694228
  sed -i.bak '8,$ d' ~/.nanohistory
  nano "${FILES}"
}

nanohistory "${@}"
