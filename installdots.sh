#!/usr/bin/env bash

function move() {
  test -f "${@}" && test -h "${@}" && return 0 # if file exists and is a symlink then skip
  rm -rf $@
  ln -s /home/pma/git/dotfiles/$@ $@
}

function doinstall() {

  if [ -f ~/.bash_env ] ; then
    source ~/.bash_env
  else
    echo 'bash_env file not created. exiting.'
    return 0
  fi

  WORKDIR=$PWD
  cd ~

  # files
  move .Xdefaults
  move .bashrc
  move .bash_aliases
  move .bash_aliases_ext
  move .bash_aliases_git
  move .bash_aliases_files
  move .fzf.bash
  move .gitconfig
  move .gitignore_global
  move .inputrc
  move .nanorc
  move .tmux.conf
  move .vimrc
  move .taskbook.json

  # folders
  mkdir -p .config
  move .config/htop
  move .config/i3
  move .config/i3status
  move .config/i3blocks
  move .config/dunst
  move .config/kitty
  move .config/ranger

  # ide
  move .atom
  mkdir -p .config/Code/User
  move .config/Code/User/keybindings.json
  move .config/Code/User/settings.json

  # nano
  touch ~/.nanohistory
  mkdir ~/.nanobackups

  # ly desktop manager
  sudo rm -rfi /etc/ly/config.ini
  sudo ln -s ~/git/dotfiles/ly.config.ini /etc/ly/config.ini

  # root
  if [ ${USER} == 'root' ] ; then
    ln -s ${HOMEDIR}/.fzf ~/.fzf
    ln -s ${HOMEDIR}/.nano ~/.nano
    ln -s ${HOMEDIR}/.nanohistory ~/.nanohistory
    ln -s ${HOMEDIR}/.tmux ~/.tmux
  fi



  cd $WORKDIR
  echo DONE
}

doinstall
