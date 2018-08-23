#! /bin/bash

function n() {
  local ARGS=( "$@" )
  local ARG=''
  local FILES=()
  local FILE=''

  if [[ $# == 0 ]] ; then
    ccat ~/.nanohistory
    exit 1
  fi

  for ARG in ${ARGS[@]} ; do
    echo -e "$PWD/$ARG\n$(cat ~/.nanohistory)" > ~/.nanohistory
    FILES=($(echo ${FILES[@]}) "$ARG") # array.push in bash :)
  done

  sed -i '8,$ d' ~/.nanohistory # truncate excessive lines
  eval nano ${FILES[@]}
}

n $@
