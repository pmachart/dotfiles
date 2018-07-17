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

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
      sed s/^..//) 2> /dev/null'

export FZF_DEFAULT_OPTS='--reverse --border --height 33%'
