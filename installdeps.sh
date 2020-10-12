#!/usr/bin/env bash

OLDPWD=$PWD

cd

curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash

git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cd ~/git
git clone https://github.com/dunst-project/dunst.git
sudo apt-get install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
cd dunst
make
sudo make install
make dunstify
mkdir -p ~/.local/bin
cp -vs $(pwd)/dunstify ~/.local/bin/

cd ~/git
git clone https://github.com/nullgemm/ly.git
cd ly
sudo apt-get install libpam0g-dev
make
sudo make install
sudo systemctl enable ly.service --force # don't disable gdm

cd

sudo apt-get install curl git libevent-dev ncurses-dev htop arandr xbacklight amixer lxappearance
sudo apt-get install feh exa bat nemo ranger flameshot ranger xdotool xinput xserver-xorg-libinput
sudo apt-get install kitty nodejs npm curl ripgrep thefuck bash-completion

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


cd $OLDPWD

echo DONE
