#! /bin/bash

function n() {
  local ARGS=( "$@" )
  local ARG=''

  if [[ $# == 0 ]] ; then
    ARGS="$('fzf')"
  fi

  for ARG in ${ARGS[@]} ; do
    echo -e "$PWD/$ARG\n$(cat ~/.nanohistory)" > ~/.nanohistory
  done

  sed -i '21,$ d' ~/.nanohistory
  nano $ARGS
}

n $@
