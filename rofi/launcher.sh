#!/usr/bin/env bash

dir="$HOME/dotfiles/rofi/styles"

rofi -no-lazy-grab -show "drun" \
-modi "drun" \
-display-drun "Apps" \
-no-show-icons \
-matching "regex" \
-hover-select \
-theme $HOME/dotfiles/rofi/theme
