#!/bin/sh

DEFAULT_ICON=
NIGHTMODE_ICON=
DEFAULT_BRIGHTNESS="1.0"
NIGHTMODE_BRIGHTNESS="0.50"
DEFAULT_GAMMA="1.0:1.0:1.0" # 6500K
NIGHTMODE_GAMMA="1.0:0.8:0.7" # 4500K


get_display_info() {
    xrandr --verbose | grep -m 1 -w "$1 connected" -A8 | grep "$2" | cut -f2- -d: | tr -d ' '
}

get_connected_displays(){
    xrandr | grep -w connected | cut -f1 -d' '
}

set_gamma_and_brightness() {
    connected_displays=$(get_connected_displays)
    for connected_display in $connected_displays; do
        xrandr --output $connected_displays --gamma $1 --brightness $2
    done
}

# gamma values returned by xrandr --verbose are somehow inverted
# https://gitlab.freedesktop.org/xorg/app/xrandr/issues/33
# this function corrects this bug by reverting the calculation
invert_gamma() {
    inv_r=$(cut -d: -f1 <<< "$1")
    inv_g=$(cut -d: -f2 <<< "$1")
    inv_b=$(cut -d: -f3 <<< "$1")
    r=$(awk '{printf "%.1f", 1/$1}' <<< "$inv_r" 2>/dev/null)
    g=$(awk '{printf "%.1f", 1/$1}' <<< "$inv_g" 2>/dev/null)
    b=$(awk '{printf "%.1f", 1/$1}' <<< "$inv_b" 2>/dev/null)
    echo "$r:$g:$b"
}

get_gamma() {
    invert_gamma "$(get_display_info "$1" 'Gamma: ')"
}

get_brightness() {
    get_display_info "$1" 'Brightness: '
}

get_display_status() {
    gamma=$(get_gamma "$1")
    brightness=$(get_brightness "$1")

    if [ $gamma = $NIGHTMODE_GAMMA ] && [ $brightness = $NIGHTMODE_BRIGHTNESS ]; then
        echo "on"
    else
        echo "off"
    fi
}

get_status() {
    connected_displays=$(get_connected_displays)
    status="on"
    for connected_display in $connected_displays; do
        status=$(get_display_status "$connected_display")
        if [ status = "off" ]; then
            break
        fi
    done

    echo $status
}

get_status_icon() {
    status=$(get_status)
    if [ $status = "on" ]; then
        echo $NIGHTMODE_ICON
    else
        echo $DEFAULT_ICON
    fi
}

exec_status() {
    status=$(get_status)
    echo "Status is $status"
}

exec_status_icon() {
    status_icon=$(get_status_icon)
    echo $status_icon
}

exec_off() {
    set_gamma_and_brightness $DEFAULT_GAMMA $DEFAULT_BRIGHTNESS
}

exec_on() {
    set_gamma_and_brightness $NIGHTMODE_GAMMA $NIGHTMODE_BRIGHTNESS
}

exec_toggle() {
    status=$(get_status)
    if [ $status = "on" ]; then
        exec_off
    else
        exec_on
    fi
}

case $1 in
    status) exec_status ;;
    status_icon) exec_status_icon ;;
    off) exec_off ;;
    on) exec_on ;;
    toggle) exec_toggle ;;
    *) echo "Unknown command" ;;
esac
