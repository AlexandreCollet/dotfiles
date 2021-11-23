#!/usr/bin/env bash

theme="$HOME/dotfiles/rofi/theme.rasi"

rofi_command="rofi -theme $dir/$theme"

# Options
shutdown="Shutdown"
reboot="Reboot"
logout="Logout"
lock="Lock"
options="$lock\n$logout\n$reboot\n$shutdown"

selection="$(echo -e "$options" | $rofi_command -dmenu -i -hover-select )"

case $selection in
    $lock) betterlockscreen -l;;
    $logout) i3-msg exit;;
    $reboot) systemctl reboot;;
    $shutdown) systemctl poweroff;;
esac
