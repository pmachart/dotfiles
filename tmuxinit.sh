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

tmuxlisa() {
  tmux rename-window "${NAME}"
  tmux send-keys "cd ${DIR}" 'C-m'
  [[ "${2}" == "vs" ]] && tmux send-keys 'code' 'C-m'
  tmux split-window -h -c "${DIR}" -p 30
  tmux send-keys "${CMD}" 'C-m'
  tmux split-window -v -c "${DIR}" -p 40
  tmux send-keys 'git stw' 'C-m'
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
    NAME='PROFILER'
    DIR='/home/pma/git/profiler'
    tmuxprofiler
    ;;
  le*)
    NAME='LISA-EKORN'
    DIR='/home/pma/git/lisa-ekorn'
    CMD='npm run start'
    tmuxlisa
    ;;
  ld*)
    NAME='LISA-DASHBOARD'
    DIR='/home/pma/git/lisa-dashboard'
    CMD='npm run start'
    tmuxlisa
    ;;
  lp*)
    NAME='LISA-PROFILER'
    DIR='/home/pma/git/lisa-profiler'
    CMD='npm run start'
    tmuxlisa
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
