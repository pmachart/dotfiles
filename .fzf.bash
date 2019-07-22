# Setup fzf
# ---------
if [[ ! "$PATH" == *~/.fzf/bin* ]]; then
  export PATH="$PATH:~/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source ~/.fzf/shell/completion.bash 2> /dev/null

# Key bindings
# ------------
source ~/.fzf/shell/key-bindings.bash

export FZF_DEFAULT_COMMAND='rg --hidden --files --sort-files'
export FZF_DEFAULT_OPTS='--reverse --border --height 33%'

export FZF_CTRL_T_COMMAND='rg --hidden --files'
export FZF_CTRL_T_OPTS="--preview-window right:60% --preview 'head -n20 {} | pygmentize -g 2> /dev/null || echo {}'"
