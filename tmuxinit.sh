#!/bin/bash

if [[ $MYENV == 't460p' ]] ; then

tmux new-session -d -s wynd -c '/home/pma/git/mellisuge'

tmux send-keys 'tb' 'C-m'
tmux select-window -t ofs:1

tmux split-window -h -c "#{pane_current_path}" -p 20
tmux send-keys 'dcdev' 'C-m'

tmux split-window -v -t 2 -c "#{pane_current_path}" -p 6
tmux send-keys 'dcw' 'C-m'

tmux split-window -h -t 1 -c "#{pane_current_path}" -p 40
tmux send-keys 'git willpull ; g' 'C-m'

tmux split-window -v -t 1 -c "#{pane_current_path}" -p 4
tmux send-keys 'yesterday'

#tmux select-pane -t 2
tmux attach -t wynd

else

tmux

fi

