#! /bin/bash

atompackagelist(){ ls ~/.atom/packages | tee ~/git/dotfiles/misc/atom_packagelist; }
vscodepackagelist(){ ls ~/.vscode/extensions | tee ~/git/dotfiles/misc/vscode_packagelist; }
scriptmove(){ rm -f $@ && ln -s ~/git/dotfiles/$@ $@; }
alias c='xclip'
alias v='xclip -o'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias grep='grep --colour=auto -i'
alias bl='tee -a ~/.bash.out.log'
alias tl='tail ~/.bash.out.log'
complete -d cd mkdir rmdir pushd
complete -f cat less more chown ln strip nano sn n svncm
bhg(){ grep "$@" ~/.bash_history; }
alias ghb=bhg
alias bht='tail -n 25 ~/.bash_history'
alias ght=bht

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
alias ld='ll --color=always | grp /$'
alias llb='ls -hlAf --color | grp ~$' # with backups

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
alias cd..='..'
alias cd,,='..'
alias cl='clear'

alias x='exit'
#alias n='nano '
alias s='sudo '
alias sn='sudo nano '
alias bashrc='nano ~/.bashrc'
alias nanorc='nano ~/.nanorc'
alias inputrc='nano ~/.inputrc'
alias gitconfig='nano ~/.gitconfig'
alias tmuxconf='nano ~/.tmux.conf'
alias tc=tmuxconf
alias gitconf=gitconfig
alias gitc=gitconfig
alias gc=gitconfig
alias als='nano ~/.bash_aliases'
alias alx='nano ~/.bash_aliases_ext'
alias alg='nano ~/.bash_aliases_git'
alias alj='nano ~/.bash_aliases_job'
alias alp='nano ~/.bash_aliases_perso'
alias profipe='nano ~/.bash_profile'
alias r='source ~/.bashrc'
alias rmdir='rm -rfi'
alias rm='rm -i'
alias rf='rm -f'
alias cp='cp -i'
alias mv='mv -i'
alias p='pwd'
alias psg='grc ps -aux | grep -v grep | grep -i '
alias pong='grc ping -c4'
pt()  { port=$(sudo lsof -t -i:$1);
  echo -e $1" : \c";
    if [ ! -z "$port" ]; then
    grc ps -aux | grep -v grep | grep " $port ";
  else
    echo "NO PROCESS";
  fi;
}
alias hc='history -a'
alias hv='history -n'
alias pp='cd $OLDPWD'
horiz() {
  local start=$'\e(0' end=$'\e(B' line='qqqqqqqqqqqqqqqq'
  local cols=${COLUMNS:-$(tput cols)}
  while ((${#line} < cols)); do line+="$line"; done
  printf '%s%s%s\n' "$start" "${line:0:cols}" "$end"
}
tf() { cl; grc tail -n 30 -f "$1"; }
srt(){ grep -v '^$' "$@" |sort -b -f -o "$@"; }

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

alias todos='ls ~/git/perso/todo* -1 -b | xargs atom'
alias notes='ls ~/git/perso/note* -1 -b | xargs atom'
alias wtfs='ls ~/git/perso/wtf* -1 -b | xargs atom'
alias todays='ls ~/git/perso/today* -1 -b | xargs atom'

alias todo='echo "$@" >> ~/git/perso/todo'
alias note='echo "$@" >> ~/git/perso/notes'
alias wtf='echo "$@" >> ~/git/perso/wtf'
alias today='echo "$(date +%F) : $@" >> ~/git/perso/today'
alias yesterday='echo "$(date -d yesterday +%F) : $@" >> ~/git/perso/today'

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


function n() {
  local file=''
  if [[ $# == 0 ]] ; then
    file=$('fzf')
  else
    file=$@
  fi
  echo $PWD/$file
  echo -e "$PWD/$file\n$(cat ~/.nanohistory)" > ~/.nanohistory
  sed -i '21,$ d' ~/.nanohistory
  nano $file
}

function nn() {
  if [ -z "$1" ]; then
    cat -n ~/.nanohistory
  else
    nano $(awk "NR == n {print; exit}" n=$1 ~/.nanohistory)
  fi
}
