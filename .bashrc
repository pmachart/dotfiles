#!/usr/bin/env bash

#[ -z "$TMUX" ] && ( tmux a || tmux )

[ -f ~/.bash_env ] && source ~/.bash_env || export HOMEDIR=${HOME}

export CDPATH=.:~:~/git:/var/lib/deluge
export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
export PATH=$PATH:~/.local/bin:~/bin:~/.bin
export PATH=$PATH:~/.linuxbrew/bin:~/.linuxbrew/opt/go/libexec/bin:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:~/.npm-global/bin
export PATH=$PATH:~/.cabal/bin

# fnm
export PATH=/home/pma/.fnm:$PATH
eval "`fnm env --multi`"

export GPG_TTY=$(tty)

if [ $USER == "root" ]; then
  alias ins='apt-get install'
  alias rem='apt-get remove'
  alias upd='apt-get update'
  alias upg='apt-get upgrade'
  alias dupg='apt-get dist-upgrade'
else
  alias ins='sudo apt-get install'
  alias rem='sudo apt-get remove'
  alias upd='sudo apt-get update'
  alias upg='sudo apt-get upgrade'
  alias dupg='sudo apt-get dist-upgrade'
fi

eval $(thefuck --alias)

GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_FETCH_REMOTE_STATUS=0
source ~/.bash-git-prompt/gitprompt.sh

alias sudo='sudo '

export EDITOR=nano
export PAGER=most

# Make directory commands see only directories
complete -d cd mkdir rm pushd

# Make file commands see only files
complete -f cat c bat b less more most m tail tf head strip nano sn n

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

TITLEBAR='\[\e]0;\u@\h\a\]'
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL="ignoredups:ignoreboth:erasedups"

#cp ~/.bash_history ~/.bash_history_backup
#awk '!x[$0]++' ~/.bash_history | tee ~/.bash_history # clear duplicates

# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE="rm:fuck:cl:l:pp:r:matin:today:todays:yesterday:note:notes:x:exit:r"
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # necessary for tmux
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # necessary for tmux


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s nocaseglob;
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes;;
esac

# pre-define colors for use in scripts and stuff
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
RESET=`tput sgr0`
BOLD=`tput bold`
MYCOLORS="${BLACK}BLACK ${RED}RED ${GREEN}GREEN ${YELLOW}YELLOW ${BLUE}BLUE ${MAGENTA}MAGENTA ${CYAN}CYAN ${WHITE}WHITE ${BOLD}BOLD${RESET}"

# Add an "alert" alias for long running commands. Use like so: > sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias initialization.
if [ -f ~/.bash_aliases ];       then . ~/.bash_aliases ;       fi
if [ -f ~/.bash_aliases_ext ];   then . ~/.bash_aliases_ext ;   fi
if [ -f ~/.bash_aliases_git ];   then . ~/.bash_aliases_git ;   fi
if [ -f ~/.bash_aliases_work ];  then . ~/.bash_aliases_work ;  fi
if [ -f ~/.bash_aliases_files ]; then . ~/.bash_aliases_files ; fi
if [ -f ~/.bash_aliases_perso ]; then . ~/.bash_aliases_perso ; fi

# enable color support of ls grep and stuff
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grp='grep'
  alias grn='grep -n'
  alias grep='grep -n --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# custom prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo " *"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
export PS1="\n$? \! \A \[$(tput sgr0)\]\[\033[38;5;11m\]\u@\h \[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \$(parse_git_branch) \\$ \[$(tput sgr0)\]\[\033[00m\]"

# initialize fuzzyfind
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias f='fzf'

cat ~/todos
alias helper="/home/pma/git/profiler/tools/helper.sh"

#source ~/.git/enhancd/init.sh
#export ENHANCD_FILTER='fzf'
