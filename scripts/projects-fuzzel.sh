#!/bin/bash

dir="$HOME/Projects/Code"
fuzzel=(fuzzel --dmenu --only-match --prompt "Projects: " \
    --minimal-lines --lines 10 --width 25)

choice=$( ls -I old "$dir" | sort | "${fuzzel[@]}" )

if [[ -n "$choice" ]]; then
    "$TERMINAL" -D "$dir/$choice" -- "$EDITOR" .
fi
