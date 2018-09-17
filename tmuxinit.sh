#!/bin/bash

tmuxwindow() {
  tmux rename-window "${NAME}"

  tmux send-keys "cd ${DIR} && tb" 'C-m'

  tmux split-window -h -c "${DIR}" -p 30
  tmux send-keys "${TOPCMD}" 'C-m'

  tmux split-window -v -t 2 -c "${DIR}" -l "${BTMCMDH}"
  tmux send-keys "${BTMCMD}" 'C-m'

  tmux split-window -h -t 1 -c "${DIR}" -p 50
  tmux send-keys 'git willpull ; g' 'C-m'

  tmux split-window -v -t 1 -c "${DIR}" -l 3
  tmux send-keys 'yesterday '
}

tmuxinit() {
  local NAME
  local DIR
  local TOPCMD
  local BTMCMD
  local BTMCMDH

  if [[ -z ${TMUX} ]] ; then
    echo 'Not in a tmux session, please create or attach to one. Exiting.'
    exit 1
  fi

  if [[ ${1} == '-n' ]] ; then
    shift
    tmux new-window
  fi

  case ${1} in
  mel*)
    NAME='MELLI'
    DIR='/home/pma/git/mellisuge'
    TOPCMD='dcdev'
    BTMCMD='dcw'
    BTNCMDH='6'
    tmuxwindow
    ;;
  boo*)
    NAME='BOOKING'
    DIR='/home/pma/git/BookingBundle'
    TOPCMD='yarn start'
    BTMCMD='htop'
    BTMCMD='9'
    tmuxwindow
    ;;
  *)
    tmux split-window -h -p 50
    tmux send-keys 'tb' 'C-m'
    tmux split-window -v -t 2 -l 9
    tmux send-keys 'htop' 'C-m'
    tmux select-pane -t 1
    ;;
  esac

}

tmuxinit "$@"
