#! /bin/bash

function n() {
  local ARGS=( "$@" )
  local ARG=''
  local FILES=''

  if [[ $# == 0 ]] ; then
    ARGS="$('fzf')"
  fi

  for ARG in ${ARGS[@]} ; do
    echo -e "$PWD/$ARG\n$(cat ~/.nanohistory)" > ~/.nanohistory
    FILES+="$ARG"
  done

  sed -i '21,$ d' ~/.nanohistory
  nano "$FILES"
}

n $@
