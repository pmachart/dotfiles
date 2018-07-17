#!/bin/bash

tmux new-session -d -s ofs -c '/home/pma/git/pegasus'

tmux send-keys 'git willpull ; g' 'C-m'
tmux select-window -t ofs:1

tmux split-window -v -c "#{pane_current_path}" -p 15
tmux send-keys 'yarn dev:client:build' 'C-m'

tmux split-window -h -t 2 -c "#{pane_current_path}"
tmux send-keys 'yarn dev:server:prepare && yarn dev:server:build' 'C-m'

tmux split-window -h -t 3 -c "#{pane_current_path}"
tmux send-keys 'tf logs/serverConsole.log' 'C-m'

tmux split-window -h -t 1 -c "#{pane_current_path}" -p 10
tmux send-keys 'sleep 85' 'C-m' 'yarn dev:server:start' 'C-m'

tmux select-pane 1
tmux attach -t ofs
