#!/bin/bash

require_tmux_running() {
  if [[ -n "${TMUX}" ]] ; then return 0 ; fi
  local TMUXLS=$(tmux ls)
  if [[ ! "${TMUXLS}" =~ 'no server running' ]] ; then
    local TMUXID=$(echo "${TMUXLS}" | \grep -vq attached | awk '{print $1}')
    if [[ -n "${TMUXID}" ]] ; then
      tmux attach -t "${TMUXID%:}"
      return 0
    fi
  else
    tmux
  fi
  exit 1
}

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

tmuxprofiler() {
  tmux rename-window 'Prof'
  tmux send-keys "cd ${DIR} && tb" 'C-m'
  tmux split-window -h -c "${DIR}" -p 40
  tmux send-keys 'make sandbox' 'C-m'
  tmux split-window -v -c "${DIR}" -p 64
  tmux send-keys 'mkb'
  tmux split-window -v -c "${DIR}" -l 16
  tmux send-keys 'dcw 2' 'C-m'
  tmux split-window -v -c "${DIR}" -l 10
  tmux send-keys 'gotop -am' 'C-m'
  tmux select-pane -t 4
  tmux split-window -h -c "${DIR}" -p 26
#  tmux send-keys 'tty-clock -c -D -C 4 -d 60s' 'C-m'
  tmux send-keys 'watch -c -t -n1 "echo ${BLUE}; date +\" %T\" | toilet -W -f smblock"' 'C-m'
  tmux select-pane -t 1
}
tmuxlisaprofiler() {
  tmux rename-window 'L-Prof'
  tmux send-keys "cd ${DIR}" 'C-m'
  tmux split-window -h -c "${DIR}" -p 40
  tmux send-keys 'make sandbox' 'C-m'
  tmux split-window -v -c "${DIR}" -p 50
  tmux send-keys 'make build'
  tmux split-window -v -c "${DIR}" -l 11
  tmux send-keys 'gotop -am' 'C-m'
  tmux select-pane -t 1
}

tmuxinit() {
  local NAME
  local DIR
  local TOPCMD
  local BTMCMD='htop'
  local BTMCMDH=8
  local NEW_TMUX=0

  if [[ ${1} == '-n' ]] ; then
    shift
    tmux new-window
  fi

  case ${1} in
  prof*)
    NAME='PROF'
    DIR='/home/pma/git/profiler'
    tmuxprofiler
    ;;
  lprof*)
    NAME='L-PROF'
    DIR='/home/pma/git/lisa-profiler'
    tmuxlisaprofiler
    ;;
  mel*)
    NAME='MELLI'
    DIR='/home/pma/git/mellisuge'
    TOPCMD='dcdev'
    BTMCMD='dcw'
    BTNCMDH='6'
    tmuxwindow
    ;;
  *)
    tmux split-window -h -p 30
    tmux send-keys 'tb' 'C-m'
    tmux split-window -v -t 2 -l 10
    tmux send-keys 'gotop -am' 'C-m'
    tmux select-pane -t 1
    ;;
  esac

}

tmuxinit "${@}"
