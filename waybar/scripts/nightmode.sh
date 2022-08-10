#!/bin/sh

DEFAULT_ICON=
NIGHTMODE_ICON=
DEFAULT_BRIGHTNESS="1.0"
NIGHTMODE_BRIGHTNESS="0.50"
DEFAULT_GAMMA="1.0:1.0:1.0" # 6500K
NIGHTMODE_GAMMA="1.0:0.8:0.7" # 4500K
STATUS_FILE_PATH="/tmp/.nightmode_status.txt"

get_status() {
    status="off"

    if [[ -f "$STATUS_FILE_PATH" ]]; then
        status=$(cat "$STATUS_FILE_PATH")
    fi

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
    echo "Nightmode is $status"
}

exec_status_icon() {
    status_icon=$(get_status_icon)
    echo $status_icon
}

exec_off() {
    wl-gammactl -c 1.000 -b 1.000 -g 1.000 &
    echo "off" > $STATUS_FILE_PATH
}

exec_on() {
    wl-gammactl -c 0.500 -b 1.000 -g 1.000 &
    echo "on" > $STATUS_FILE_PATH
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
