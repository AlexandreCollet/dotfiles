#!/bin/sh

mkdir -p $HOME/.config/

# x11
ln -sfn $PWD/x11/xresources $HOME/.Xresources
#sudo ln -sfn $PWD/x11/xorg/* /etc/X11/xorg.conf.d/

# I3
ln -sfn $PWD/i3/ $HOME/.config/

# Polybar
ln -sfn $PWD/polybar/ $HOME/.config/

# Rofi
mkdir -p $HOME/.local/share/applications/
ln -sfn $PWD/rofi/applications/* $HOME/.local/share/applications/

# Terminal
ln -sfn $PWD/alacritty/ $HOME/.config/
ln -sfn $PWD/zsh/zshrc $HOME/.zshrc

# Autorandr
ln -sfn $PWD/autorandr $HOME/.config/

# Code
mkdir -p $HOME/.config/Code/User
ln -sfn $PWD/code/* $HOME/.config/Code/User/
ln -sfn $PWD/git/gitconfig $HOME/.gitconfig
