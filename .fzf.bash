# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pma/.fzf/bin* ]]; then
  export PATH="$PATH:/home/pma/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pma/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/pma/.fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='rg --hidden --files --sort-files'
export FZF_DEFAULT_OPTS='--reverse --border --height 33%'

export FZF_CTRL_T_COMMAND='rg --hidden --files'
export FZF_CTRL_T_OPTS="--preview-window right:60% --preview 'head -n20 {} | pygmentize -g 2> /dev/null || echo {}'"
