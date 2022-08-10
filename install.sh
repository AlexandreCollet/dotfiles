#!/bin/sh

SCRIPT_PATH=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT_PATH")

mkdir -p $HOME/.config/

# x11
ln -sfn $BASEDIR/x11/xresources $HOME/.Xresources

# Fusuma
ln -sfn $BASEDIR/fusuma/ $HOME/.config/

# I3 / Sway
ln -sfn $BASEDIR/i3/ $HOME/.config/
ln -sfn $BASEDIR/sway/ $HOME/.config/

# Polybar / Waybar
ln -sfn $BASEDIR/polybar/ $HOME/.config/
ln -sfn $BASEDIR/waybar/ $HOME/.config/

# Rofi
mkdir -p $HOME/.local/share/applications/
ln -sfn $BASEDIR/rofi $HOME/.config/
ln -sfn $BASEDIR/rofi/applications/* $HOME/.local/share/applications/

# Terminal
ln -sfn $BASEDIR/alacritty/ $HOME/.config/
ln -sfn $BASEDIR/zsh/zprofile $HOME/.zprofile
ln -sfn $BASEDIR/zsh/zshrc $HOME/.zshrc
ln -sfn $BASEDIR/zsh/zshenv $HOME/.zshenv

# Autorandr
ln -sfn $BASEDIR/autorandr $HOME/.config/

# Code
mkdir -p $HOME/.config/Code/User
ln -sfn $BASEDIR/code/* $HOME/.config/Code/User/
ln -sfn $BASEDIR/git/gitconfig $HOME/.gitconfig
