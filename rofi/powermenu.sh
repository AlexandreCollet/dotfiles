#!/usr/bin/env bash

# Options
shutdown="Shutdown"
reboot="Reboot"
logout="Logout"
lock="Lock"
options="$lock\n$logout\n$reboot\n$shutdown"

selection="$(echo -e "$options" | rofi -dmenu -i )"

case $selection in
    $lock) dm-tool switch-to-greeter;;
    $logout) i3-msg exit;;
    $reboot) systemctl reboot;;
    $shutdown) systemctl poweroff;;
esac
