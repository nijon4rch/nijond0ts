#!/bin/sh

STATE_FILE="/tmp/qwrttoggled"

if [ -f "$STATE_FILE" ]; then
    # Restore normal layouts
    hyprctl reload

    rm "$STATE_FILE"

    notify-send "Keyboard Layout" "Toggled QWERTY OFF"
else
    # Save state
    touch "$STATE_FILE"

    # Force temporary QWERTY
    hyprctl keyword input:kb_layout us
    hyprctl keyword input:kb_variant ""

    notify-send "Keyboard Layout" "Toggled QWERTY ON"
fi
