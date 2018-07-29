#!/bin/bash

function scriptmove() {
  rm -f $@ && ln -s ~/git/dotfiles/$@ $@;
}

WORKDIR=$PWD

cd

scriptmove .bashrc
scriptmove .bash_aliases
scriptmove .bash_aliases_ext
scriptmove .bash_aliases_git
scriptmove .bash_aliases_files
scriptmove .fzf.bash
scriptmove .gitconfig
scriptmove .inputrc
scriptmove .nanorc
scriptmove .tmux.conf
scriptmove .vimrc

if [ -d ".atom" ]; then
  scriptmove .atom/config.cson
  scriptmove .atom/init.coffee
  scriptmove .atom/keymap.cson
  scriptmove .atom/styles.less
else
  echo ".atom folder does not exist. Run atom once before running this script"
fi

if [ -d ".config/Code/User" ]; then
  scriptmove .config/Code/User/keybindings.json
  scriptmove .config/Code/User/settings.json
else
  echo ".config/code/User folder does not exist. Run vscode once before running this script"
fi

mkdir -p .config/htop
scriptmove .config/htop/htoprc

echo DONE

cd $WORKDIR
