#!/usr/bin/env bash

function move() {
  test -f "${@}" && test -h "${@}" && return 0 # if file exists and is a symlink then skip
  rm -rfi $@ && ln -s ~/git/dotfiles/$@ $@;
}

WORKDIR=$PWD

cd

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
move .config/dunst
move .config/polybar

# ide
scriptmove .atom
mkdir -p .config/Code
move .config/Code/User/keybindings.json
move .config/Code/User/settings.json

# nano
touch ~/.nanohistory
mkdir ~/.nanobackups

echo DONE

cd $WORKDIR
