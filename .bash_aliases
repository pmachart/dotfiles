#!/usr/bin/env bash

alias b='bat'
alias m='most'
alias f='find -maxdepth 0 ${@} -ls'
alias cv='command -v'
alias c='xclip'
alias v='xclip -o'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias bl='tee -a ~/.bash.out.log'
alias tl='tail ~/.bash.out.log'
bhg(){ grep "$@" ~/.bash_history; }
alias ghb=bhg
alias bht='tail -n 25 ~/.bash_history'
alias ght=bht

alias e='exa --group-directories-first --git --grid'
alias ee='e --long'
alias ea='e --all'
alias eea='ee --all'
alias ed='e --list-dirs */'
alias et='e --tree --level=2'

alias l='ls -BhF --group-directories-first '
alias ll='ls -BhlAF --group-directories-first '
alias lls='ll -S'
alias llsize='lls'
alias llx='ll -X'
alias llxtension='llx'
alias llt='ll -t'
alias lltime='llt'
alias llr='ll -R'

alias lf='ls -hlAF --color | grep -v ^d'
alias ld='ll --color=always | \grep /$'
alias lf='find .* -maxdepth 0 -ls | grep -v [.]$'
alias llb='ls -hlAf --color | \grep ~$' # with backups

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ,,='..'
alias ,,,='...'
alias ,,,,='....'
alias ,,,,,='.....'
alias ,,,,,,='......'

alias x='exit'
alias s='sudo '
alias sn='sudo nano '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias p='pwd'
alias cl='clear'
alias ra='ranger'
alias psg='grc ps -aux | \grep -v grep | grep -i '
alias pong='grc ping -c4'
alias caps='xdotool key Caps_Lock'
alias CAPS='caps'
alias cqps='caps'
alias CQPS='caps'

pt()  { local -r PID=$(sudo lsof -t -i:$1);
  echo -e $1" : \c";
    if [ ! -z "${PID}" ]; then
    psg ${PID}
  else
    echo "NO PROCESS";
  fi;
}
alias hc='history -a'
alias hv='history -n'
alias pp='cd $OLDPWD'

hr() {
printf '━%.0s' $(seq $(tput cols))
}
alias horiz=hr

tf() { cl; grc tail -n 30 -f "$1"; }
srt(){ grep -v '^$' "$@" | sort -b -f -o "$@"; }

loc() {
  if [ $USER == "root" ]; then
    updatedb
  else
    sudo updatedb
  fi
  local lo=$(locate -i $1)
  local i=1
  if [ -z "$2" ]; then
    for j in $lo; do
      printf "[$i]\t`date +%Y/%m/%d-%H:%M -r $j`\t$j\n"
      ((i++))
    done
  else
    for j in $lo; do
      if [[ "$2" = "$i" ]]; then
        echo "$j"
        if [[ "$3" = "n" ]]; then
          sn $j
        fi
        if [[ "$3" = "cd" ]]; then
          cd $j
        fi
      fi
      ((i++))
    done
  fi
}

function extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"      ;;
            *.tar.gz)   tar xzf "$1"      ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      rar x "$1"        ;;
            *.gz)       gunzip "$1"       ;;
            *.tar)      tar xf "$1"       ;;
            *.tbz2)     tar xjf "$1"      ;;
            *.tgz)      tar xzf "$1"      ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function nn() {
  if [ -z "${1}" ]; then
    cat -n ~/.nanohistory
  else
    local -r FILE=$(sed -n "${1}p" < ~/.nanohistory)
    nano "${FILE}"
  fi
}

alias hasinternet='ping -c1 4.2.2.1 &>/dev/null'
alias internet='hasinternet && parrotsay "Yay ! Internet !" || parrotsay "No internets :("'
alias waitinternet='while true; do hasinternet && parrotsay "The Internets are back !" && break; done'

function showalias() {
  if [[ $(type -t ${1}) == "function" ]] ; then
    declare -f ${1}
    return 0
  fi
  \alias ${@}
}
