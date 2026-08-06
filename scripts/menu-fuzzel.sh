#!/bin/bash

fuzzel=(fuzzel --dmenu --no-input --prompt "Are you sure? " --minimal-lines --width 12)
choice=$(printf 'Logout\nCancel\n' | "${fuzzel[@]}" )

if [[ "$choice" == 'Logout' ]]; then
  hyprshutdown --post-cmd 'uwsm stop'
fi
