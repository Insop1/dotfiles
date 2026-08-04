#!/bin/bash

choice=$(printf 'Logout\nCancel\n' | fuzzel --dmenu --only-match --prompt "Are you sure? " --minimal-lines --width=12)

if [ "$choice" == 'Logout' ]; then
  hyprshutdown --post-cmd 'uwsm stop'
fi
