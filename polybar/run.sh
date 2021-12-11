#!/usr/bin/env bash

export POLYBAR_SHELL=zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 0.1; done

# Launch polybar on multiple screens
if type "xrandr"; then
    xrandr --query | grep -E " connected (primary )?[1-9]+" | while read -r line; do
        monitor=$(echo $line | cut -d " " -f1)
        if $(echo "$line" | grep -q "3840x2160"); then
            MONITOR=$monitor polybar --reload "$1_x2" &
        else
            MONITOR=$monitor polybar --reload $1 &
        fi

    done
else
    polybar --reload $1 &
fi
