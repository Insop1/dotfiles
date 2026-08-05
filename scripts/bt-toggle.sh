#!/usr/bin/env bash

state=$(bluetoothctl show | grep -oP 'Powered: \K(yes|no)')

if [[ "$state" = "yes" ]]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi

